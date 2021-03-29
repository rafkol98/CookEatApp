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
    
    
    init(user: User) {
        self.user = user
        checkIfFollowing()
    }
    
    //    Follow user displayed.
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
    
    //  Unfollow user displayed.
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
    
    //   Check if the current user is following the user displayed now.
    func checkIfFollowing() {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        let followingRef = COLLECTION_USERS.document(userUid).collection("users-following")
        
        followingRef.document(self.user.id).getDocument { snapshot, _ in
            guard let isFollowed = snapshot?.exists else {return}
            self.isFollowed = isFollowed
        }
    }
}


