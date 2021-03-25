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
    func upload(name: String, description: String, ingredients: String, instructions: String) {
                guard let user = AuthViewModel.shared.user else {return}
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
                                            "likes":0, "id": docRef.documentID]
                
                docRef.setData(data) { (_) in
                    print("Successfully uploaded tweet")
                }
        }
    }
    

