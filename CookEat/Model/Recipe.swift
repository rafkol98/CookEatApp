//
//  Recipe.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 26/03/2021.
//
//  Model containing the fields of a recipe.

import Firebase


struct Recipe: Identifiable {
    // Recipe data
    let id: String
    let recipeName: String
    let description: String
    let ingredients: Array<String>
    let instructions: Array<String>
    let username: String
    let profileImageUrl: String
    let fullname: String
    let uid: String
    let likes: Int
    let timestamp: Timestamp
    let foodImageUrl: String
    
    
    // Initialize variables from dictionary that we get from Firebase.
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.recipeName = dictionary["recipeName"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.ingredients = dictionary["ingredients"] as? Array<String> ?? []
        self.instructions = dictionary["instructions"] as? Array<String> ?? []
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.foodImageUrl = dictionary["foodImageUrl"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.uid = dictionary["uid"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
    
    
}
