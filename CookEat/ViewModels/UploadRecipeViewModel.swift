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
    func upload(name: String, description: String, ingredients: Array<String>, instructions: Array<String>, image: UIImage) {
        guard let user = AuthViewModel.shared.user else {return}
        
        //Check if all the values are valid
        if (!invalid(varIn: name, boundary: 50) && !invalid(varIn: description, boundary: 1000) && !invalidArray(varIn: ingredients) && !invalidArray(varIn: instructions)) {
            
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
                    
                    docRef.setData(data) { (_) in
                        print("Successfully uploaded recipe")
                    }
                    
                }
            }
        } else {
            print("invalid")
        }
    }
    
    
}
