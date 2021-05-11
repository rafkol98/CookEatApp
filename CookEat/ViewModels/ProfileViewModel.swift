//
//  ProfileViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 22/03/2021.
//
//  All the functions associated with a profile of a user. Offers functionalities to follow other users, like their recipes etc.

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
        
        // Add followed user's uid to the current user.
        followingRef.document(self.user.id).setData([:]) { error in
            // Catch error.
            if let error = error {
                print("Error following user: \(error)")
            } else {
                //Add current user's uid to the followed user.
                followersRef.document(userUid).setData([:]) { error in
                    // Catch error.
                    if let error = error {
                        print("Error following user: \(error)")
                    } else {
                        self.isFollowed = true
                    }
                }
            }
        }
    }
    
    // Unfollow user displayed.
    func unfollow() {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        
        let followingRef = COLLECTION_USERS.document(userUid).collection("users-following")
        let followersRef = COLLECTION_USERS.document(user.id).collection("users-followers")
        
        followingRef.document(self.user.id).delete { error in
            // Catch error.
            if let error = error {
                print("Error unfollowing user: \(error)")
            } else {
                followersRef.document(userUid).delete { error in
                    if let error = error {
                        print("Error unfollowing user: \(error)")
                    } else {
                        self.isFollowed = false
                    }
                }
            }
        }
    }
    
    //  Check if the current user is following the user displayed now.
    func checkIfFollowing() {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        let followingRef = COLLECTION_USERS.document(userUid).collection("users-following")
        
        followingRef.document(self.user.id).getDocument { snapshot, error in
            if let error = error {
                print("Failed to fetch liked recipes: \(error.localizedDescription)")
                return
            }
            
            guard let isFollowed = snapshot?.exists else {return}
            self.isFollowed = isFollowed
        }
    }
    
    //Fetch recipes of the user.
    func fetchUserRecipes() {
        COLLECTION_RECIPES.whereField("uid", isEqualTo: user.id).addSnapshotListener { snapshot, error in
            // Catch error.
            if let error = error {
                print("Failed to fetch user's recipes: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            //Populate user recipes.
            self.userRecipes = documents.map({ Recipe(dictionary: $0.data()) })
        }
    }
    
    // Fetch recipes that the user likes.
    func fetchLikedRecipes() {
        COLLECTION_USERS.document(user.id).collection("user-likes").addSnapshotListener { snapshot, error in
            // Catch error.
            if let error = error {
                print("Failed to fetch liked recipes: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            let recipeIDs = documents.map({$0.documentID})
            
            recipeIDs.forEach { id in
                COLLECTION_RECIPES.document(id).addSnapshotListener { snapshot, error in
                    // Catch error.
                    if let error = error {
                        print("Failed to fetch liked recipes: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let data = snapshot?.data() else { return }
                    let recipe = Recipe(dictionary: data)
                    self.likedRecipes.append(recipe)
                }
            }
            
        }
    }
    
    // Get count of followers and followings.
    func getCount() {
        COLLECTION_USERS.document(user.id).collection("users-followers").addSnapshotListener { snapshot, error in
            if let error = error {
                print("Failed to get count of followers: \(error.localizedDescription)")
                return
            }
            
            // Assign followers count.
            guard let followerCount = snapshot?.documents.count else { return }
            self.followers = followerCount
        }
        COLLECTION_USERS.document(user.id).collection("users-following").addSnapshotListener { snapshot, error in
            if let error = error {
                print("Failed to get count of followers: \(error.localizedDescription)")
                return
            }
            
            // Assign following count.
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


