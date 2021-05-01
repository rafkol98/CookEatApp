//
//  Recipe.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 10/04/2021.
//
//  Model containing the fields of a contribution.

import Firebase


struct Contribution: Identifiable {
    // Contribution data. Contains both new data that was contributed and data of the original recipe.
    let id: String
    let status: String
    let originalId: String
    let recipeName: String
    let addedIngredients: Array<String>
    let addedInstructions: Array<String>
    let removedIngredients: Array<String>
    let removedInstructions: Array<String>
    let suggestedIngredients: Array<String>
    let suggestedInstructions: Array<String>
    let username: String
    let originalUsername: String
    let profileImageUrl: String
    let originalProfileImageUrl: String
    let fullname: String
    let originalFullname: String
    let uid: String
    let originalUid: String
    let timestamp: Timestamp
    let originalTimestamp: Timestamp
    let originalIngredients: Array<String>
    let originalInstructions: Array<String>



    // Initialize variables from dictionary that we get from Firebase.
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.status = dictionary["status"] as? String ?? ""
        self.originalId = dictionary["originalId"] as? String ?? ""
        self.recipeName = dictionary["recipeName"] as? String ?? ""
        self.originalIngredients = dictionary["originalIngredients"] as? Array<String> ?? []
        self.originalInstructions = dictionary["originalInstructions"] as? Array<String> ?? []
        self.addedIngredients = dictionary["addedIngredients"] as? Array<String> ?? []
        self.addedInstructions = dictionary["addedInstructions"] as? Array<String> ?? []
        self.suggestedIngredients = dictionary["suggestedIngredients"] as? Array<String> ?? []
        self.suggestedInstructions = dictionary["suggestedInstructions"] as? Array<String> ?? []
        self.removedIngredients = dictionary["removedIngredients"] as? Array<String> ?? []
        self.removedInstructions = dictionary["removedInstructions"] as? Array<String> ?? []
        self.username = dictionary["username"] as? String ?? ""
        self.originalUsername = dictionary["originalUsername"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.originalProfileImageUrl = dictionary["originalProfileImageUrl"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.originalFullname = dictionary["originalFullname"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.originalUid = dictionary["originalUid"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.originalTimestamp = dictionary["originalTimestamp"] as? Timestamp ?? Timestamp(date: Date())

    }
    
    
}

