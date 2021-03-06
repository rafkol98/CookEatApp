//
//  UploadRecipeViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 25/03/2021.
//
//  ViewModel containing a function used to upload a recipe to the database.

import SwiftUI
import Firebase

class UploadRecipeViewModel: ObservableObject {
    
    // Upload recipe to database.
    func upload(name: String, description: String, ingredients: Array<String>, instructions: Array<String>, image: UIImage) {
        guard let user = AuthViewModel.shared.user else {return}
        
        //Check if all the values are valid
        if (!invalid(varIn: name, minBoundary: 5, maxBoundary: 50) && !invalid(varIn: description, minBoundary: 10, maxBoundary: 1000) && !invalidArray(varIn: ingredients) && !invalidArray(varIn: instructions)) {
            
            //upload image.
            guard let imageData = image.jpegData(compressionQuality: 0.3) else { return }
            let filename = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child(filename)
            
            // Store image to firebase storage.
            storageRef.putData(imageData, metadata: nil) { _, error in
                if let error = error {
                    print("Failed to upload image \(error.localizedDescription)")
                    return
                }
                // Get an image url for the picture.
                storageRef.downloadURL { url, _ in
                    guard let foodImageUrl = url?.absoluteString else { return }
                    
                    let docRef = COLLECTION_RECIPES.document()
                    
                    let data : [String: Any] = ["uid": user.id,
                                                "recipeName": name,
                                                "description": description,
                                                "ingredients": ingredients,
                                                "instructions": instructions,
                                                "fullname": user.fullname,
                                                "timestamp": Timestamp(date: Date()),
                                                "username": user.username,
                                                "profileImageUrl": user.profileImageUrl,
                                                "likes":0, "id": docRef.documentID,
                                                "foodImageUrl": foodImageUrl]
                    
                    // Set initial commit to history.
                    let versionControlRef = COLLECTION_RECIPES.document(docRef.documentID).collection("history").document()
                    
                    docRef.setData(data) { (_) in
                        print("Successfully uploaded recipe")
                        let data : [String: Any] = ["uid": user.id,
                                                    "originalId": docRef.documentID,
                                                    "id": versionControlRef.documentID,
                                                    "recipeName": name,
                                                    "description": description,
                                                    "addedIngredients": ingredients,
                                                    "addedInstructions": instructions,
                                                    "suggestedIngredients": ingredients,
                                                    "suggestedInstructions": instructions,
                                                    "fullname": user.fullname,
                                                    "timestamp": Timestamp(date: Date()),
                                                    "username": user.username,
                                                    "profileImageUrl": user.profileImageUrl,
                                                    "status": "Initial Commit"
                        ]
                        
                        versionControlRef.setData(data)
                    }
                    
                }
            }
        } else {
            print("invalid")
        }
    }
    
    
}
