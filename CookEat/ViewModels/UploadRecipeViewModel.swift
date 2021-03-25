//
//  UploadRecipeViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 25/03/2021.
//

import SwiftUI
import Firebase

class UploadRecipeViewModel: ObservableObject {
//  Upload recipe.
    
    func upload(recipeName: String, description: String, ingredients: String, instructions: String) {
        print("test")
        guard let user = AuthViewModel.shared.user else { return }
        
        //      Get reference ID of recipes document.
        let docRef = COLLECTION_RECIPES.document()
        
//        Initialise the data that we will pass in the recipe.
        let data: [String: Any] = ["uid": user.id, "timestamp": Timestamp(date: Date()),"recipeName": recipeName, "description": description, "ingredients": ingredients, "instructions": instructions, "fullname": user.fullname, "username": user.username, "profileImageUrl": user.profileImageUrl, "likes":0, "id": docRef.documentID]
        
        docRef.setData(data) { _ in
            print("uploaded")
        }
    }
    
}
