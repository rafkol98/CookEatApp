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
    func upload(name: String, description: String, ingredients: String, instructions: String, image: UIImage) {
        guard let user = AuthViewModel.shared.user else {return}
        
        //upload image.
        guard let imageData = image.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child(filename)
        
        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("Failed to upload image \(error.localizedDescription)")
                return
            }
            // Get an image url for the picture.
            storageRef.downloadURL { url, _ in
                guard let foodImageUrl = url?.absoluteString else { return }
                
                let docRef = COLLECTION_RECIPES.document()
                //Split the ingredients and instructions into arrays. These way it will be easier to understand when something was removed.
                let ingredientsLines = ingredients.components(separatedBy: "\n")
                let instructionsLines = instructions.components(separatedBy: "\n")
                
                let data : [String: Any] = ["uid": user.id,
                                            "recipeName": name,
                                            "description": description,
                                            "ingredients": ingredientsLines,
                                            "instructions": instructionsLines,
                                            "fullname": user.fullname,
                                            "timestamp": Timestamp(date: Date()),
                                            "username": user.username,
                                            "profileImageUrl": user.profileImageUrl,
                                            "likes":0, "id": docRef.documentID,
                                            "foodImageUrl": foodImageUrl]
                
                docRef.setData(data) { (_) in
                    print("Successfully uploaded recipe")
                }
                
            }
        }
    }
    
    
}
