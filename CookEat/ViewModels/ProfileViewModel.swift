//
//  ProfileViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 22/03/2021.
//

import SwiftUI
import Firebase

class ProfileViewModel: ObservableObject {
    let user: User
    @Published var isFollowed = false
    @Published var userRecipes = [Recipe]()
    @Published var likedRecipes = [Recipe]()
    @Published var followers = 0
    @Published var following = 0
    
    
    init(user: User) {
        self.user = user
        checkIfFollowing()
        fetchUserRecipes()
        fetchLikedRecipes()
        getCount()
    }
    
    // Follow user displayed.
    func follow() {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        
        let followingRef = COLLECTION_USERS.document(userUid).collection("users-following")
        let followersRef = COLLECTION_USERS.document(user.id).collection("users-followers")
        
        followingRef.document(self.user.id).setData([:]) { _ in
            followersRef.document(userUid).setData([:]) { _ in
                self.isFollowed = true
            }
        }
    }
    
    // Unfollow user displayed.
    func unfollow() {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        
        let followingRef = COLLECTION_USERS.document(userUid).collection("users-following")
        let followersRef = COLLECTION_USERS.document(user.id).collection("users-followers")
        
        followingRef.document(self.user.id).delete { _ in
            followersRef.document(userUid).delete { _ in
                self.isFollowed = false
            }
        }
    }
    
    //  Check if the current user is following the user displayed now.
    func checkIfFollowing() {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        let followingRef = COLLECTION_USERS.document(userUid).collection("users-following")
        
        followingRef.document(self.user.id).getDocument { snapshot, _ in
            guard let isFollowed = snapshot?.exists else {return}
            self.isFollowed = isFollowed
        }
    }
    
    //Fetch recipes of the user.
    func fetchUserRecipes() {
        COLLECTION_RECIPES.whereField("uid", isEqualTo: user.id).addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            //Populate user recipes.
            self.userRecipes = documents.map({ Recipe(dictionary: $0.data()) })
        }
    }
    
    //Fetch recipes that the user likes.
    func fetchLikedRecipes() {
        COLLECTION_USERS.document(user.id).collection("user-likes").addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let recipeIDs = documents.map({$0.documentID})
            
            recipeIDs.forEach { id in
                COLLECTION_RECIPES.document(id).addSnapshotListener { snapshot, _ in
                    guard let data = snapshot?.data() else { return }
                    let recipe = Recipe(dictionary: data)
                    self.likedRecipes.append(recipe)
                }
            }
            
        }
    }
    
    // Get count of followers and followings.
    func getCount() {
        COLLECTION_USERS.document(user.id).collection("users-followers").addSnapshotListener { snapshot, _ in
            guard let followerCount = snapshot?.documents.count else { return }
            self.followers = followerCount
        }
        COLLECTION_USERS.document(user.id).collection("users-following").addSnapshotListener { snapshot, _ in
            guard let followingCount = snapshot?.documents.count else { return }
            self.following = followingCount
        }
    }
    
    // Used for the filter between recipes and likes.
    func recipes(forFilter filter: FilterOptions) -> [Recipe] {
        switch filter {
        case .one: return userRecipes
        case .two: return likedRecipes
        }
    }
}


