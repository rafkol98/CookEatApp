//
//  User.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 14/03/2021.
//
//  Model containing the fields of a user.

import Foundation
import Firebase

struct User: Identifiable {
//    User data
    let id: String
    let email: String
    let username: String
    let profileImageUrl: String
    let fullname: String
    let currentUser: Bool
    
//    Initialize variables from dictionary that we get from Firebase.
    init(dictionary: [String: Any]) {
        self.id = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.currentUser = Auth.auth().currentUser?.uid == self.id
    }
}
