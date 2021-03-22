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
    }
    
    func follow() {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        
//        Add uid of user to be followed in the current user's following document.
        COLLECTION_FOLLOWING.document(userUid).collection("user-following").document(user.id).setData([:]) { _ in
//            Add current user's uid in the followers list of the other user.
            COLLECTION_FOLLOWERS.document(self.user.id).collection("user-followers").document(userUid).setData([:]) { _ in
                self.isFollowed = true
            }
        }
    }
    
    func unfollow() {
        print("unfollow")
    }
}


