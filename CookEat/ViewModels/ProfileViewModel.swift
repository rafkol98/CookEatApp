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
        let followingRef = COLLECTION_FOLLOWING.document(userUid).collection("user-following")
        let followersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")
        
        //        Add uid of user to be followed in the current user's following document.
        followingRef.document(user.id).setData([:]) { _ in
            
            //            Add current user's uid in the followers list of the other user.
            followersRef.document(self.user.id).collection("user-followers").document(userUid).setData([:]) { _ in
                self.isFollowed = true
            }
        }
    }
    
//  Unfollow user displayed.
    func unfollow() {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        let followingRef = COLLECTION_FOLLOWING.document(userUid).collection("user-following")
        let followersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")
        
        followingRef.document(user.id).delete{ _ in
            followersRef.document(userUid).delete {_ in
                self.isFollowed = false
            }
        }
    }
    
//   Check if the current user is following the user displayed now.
    func checkIfFollowing() {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        let followingRef = COLLECTION_FOLLOWING.document(userUid).collection("user-following")
        
        followingRef.document(user.id).getDocument { snapshot, _ in
            guard let isFollowed = snapshot?.exists else {return}
            self.isFollowed = isFollowed
        }
    }
}


