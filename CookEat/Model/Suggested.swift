//
//  Recipe.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 10/04/2021.
//

import Firebase


struct Suggested: Identifiable {
    let id: String
    let recipeName: String
    let addedIngredients: Array<String>
    let addedInstructions: Array<String>
    let removedIngredients: Array<String>
    let removedInstructions: Array<String>
    let username: String
    let profileImageUrl: String
    let fullname: String
    let uid: String
    let timestamp: Timestamp
    let originalIngredients: Array<String>
    let originalInstructions: Array<String>



//    Initialize variables from dictionary that we get from Firebase.
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.recipeName = dictionary["recipeName"] as? String ?? ""
        self.originalIngredients = dictionary["originalIngredients"] as? Array<String> ?? []
        self.originalInstructions = dictionary["originalInstructions"] as? Array<String> ?? []
        self.addedIngredients = dictionary["addedIngredients"] as? Array<String> ?? []
        self.addedInstructions = dictionary["addedInstructions"] as? Array<String> ?? []
        self.removedIngredients = dictionary["removedIngredients"] as? Array<String> ?? []
        self.removedInstructions = dictionary["removedInstructions"] as? Array<String> ?? []
        
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
       
        self.fullname = dictionary["fullname"] as? String ?? ""
        
        self.uid = dictionary["uid"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())

    }
    
    
}

