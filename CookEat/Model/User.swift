//
//  User.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 13/03/2021.
//

import Foundation

struct User: Identifiable {
//    User data
    let id: String
    let email: String
    let username: String
    let profileImageUrl: String
    let fullname: String
    
//    Initialize variables from dictionary that we get from Firebase.
    init(dictionary: [String: Any]) {
        self.id = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
    }
}
