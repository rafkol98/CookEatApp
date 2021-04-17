//
//  RecipeViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 28/03/2021.
//

import SwiftUI
import Firebase

class RecipeViewModel: ObservableObject {
    let recipe: Recipe
    @Published var didLike = false
    
    
    init(recipe: Recipe) {
        self.recipe = recipe
        checkIfUserLiked()
    }
    
    //Like a recipe.
    func likeRecipe() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let recipeLikesRef = COLLECTION_RECIPES.document(recipe.id).collection("recipe-likes")
        let userLikesRef = COLLECTION_USERS.document(uid).collection("user-likes")
        
        COLLECTION_RECIPES.document(recipe.id).updateData(["likes": recipe.likes + 1 ]){ _ in
            recipeLikesRef.document(uid).setData([:]) { _ in
                userLikesRef.document(self.recipe.id).setData([:]) { _ in
                    self.didLike = true
                }
            }
        }
        
    }
    
    //Unlike a recipe
    func unlikeRecipe() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let recipeLikesRef = COLLECTION_RECIPES.document(recipe.id).collection("recipe-likes")
        let userLikesRef = COLLECTION_USERS.document(uid).collection("user-likes")
        
        COLLECTION_RECIPES.document(recipe.id).updateData(["likes": recipe.likes - 1]){ _ in
            recipeLikesRef.document(uid).delete { _ in
                userLikesRef.document(self.recipe.id).delete { _ in
                    self.didLike = false
                }
            }
        }
    }
    
    //Check if user liked a recipe.
    func checkIfUserLiked() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let userLikesRef = COLLECTION_USERS.document(uid).collection("user-likes").document(recipe.id)
        
        userLikesRef.addSnapshotListener { snapshot, _ in
            guard let didLike = snapshot?.exists else { return }
            self.didLike = didLike
        }
    }
    
    //Check if user liked a recipe.
    func edit(name: String, description: String, ingredients: Array<String>, instructions: Array<String>) {
        //        let docRef = COLLECTION_RECIPES.document(recipe.id)
        
        COLLECTION_RECIPES.document(recipe.id).updateData([
            "recipeName": name,
            "description": description,
            "ingredients": ingredients,
            "instructions": instructions
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        
    }
    
    //delete recipe
    func deleteRecipe() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let receivedRef = COLLECTION_USERS.document(uid).collection("received")
        
        COLLECTION_RECIPES.document(recipe.id).delete { _ in
            receivedRef.whereField("originalId", in: [self.recipe.id]).getDocuments { (snapshot, error) in
                if let snapshot = snapshot?.documents {
                    for document in snapshot {
                        //create a temporary contribution object
                        let temp = Contribution(dictionary: document.data())
                        
                        //Delete all the received contributions
                        receivedRef.document(document.documentID).delete() { err in
                            if let err = err {
                                print("Error deleting document: \(err)")
                            } else {
                                //delete the suggested contirbution sent by another user.
                                COLLECTION_USERS.document(temp.uid).collection("suggested").document(document.documentID).delete() { err in
                                    if let err = err {
                                        print("Error deleting document: \(err)")
                                    } else {
                                        print("Documents successfully deleted")
                                    }
                                    
                                }
                                }
                            }
                            
                        }
                    }
                }
                
            }
        }
        
        //Fork recipe
        func forkRecipe() {
            guard let user = AuthViewModel.shared.user else {return}
            guard let uid = AuthViewModel.shared.userSession?.uid else { return }
            
            COLLECTION_RECIPES.document(recipe.id).getDocument{ snapshot, _ in
                guard var data = snapshot?.data() else { return }
                let docRef = COLLECTION_RECIPES.document()
                
                //update values.
                data.updateValue(uid, forKey: "uid")
                data.updateValue(docRef.documentID, forKey: "id")
                data.updateValue(user.username, forKey: "username")
                data.updateValue(user.fullname, forKey: "fullname")
                data.updateValue(user.profileImageUrl, forKey: "profileImageUrl")
                data.updateValue(0, forKey: "likes")
                data.updateValue(Timestamp(date: Date()), forKey: "timestamp")
                
                docRef.setData(data) { (_) in
                    print("Successfully uploaded recipe")
                }
            }
        }
        
        //TODO: validation.
        func contributeRecipe(addedIngredients: Array<String>, addedInstructions: Array<String>, removedIngredients: Array<String>, removedInstructions: Array<String>, suggestedIngredients: Array<String>, suggestedInstructions: Array<String>) {
            guard let user = AuthViewModel.shared.user else {return}
            
            let userSuggestedRef = COLLECTION_USERS.document(user.id).collection("suggested").document()
            let userReceivedRef = COLLECTION_USERS.document(recipe.uid).collection("received").document(userSuggestedRef.documentID)
            
            
            let data : [String: Any] = [
                "id": userSuggestedRef.documentID,
                "status": "Waiting",
                "originalId": recipe.id,
                "uid": user.id,
                "originalUid": recipe.uid,
                "recipeName": recipe.recipeName,
                "addedIngredients": addedIngredients,
                "addedInstructions": addedInstructions,
                "removedIngredients": removedIngredients,
                "removedInstructions": removedInstructions,
                "originalIngredients": recipe.ingredients,
                "originalInstructions": recipe.instructions,
                "suggestedIngredients": suggestedIngredients,
                "suggestedInstructions": suggestedInstructions,
                "fullname": user.fullname,
                "originalFullname": recipe.fullname,
                "timestamp": Timestamp(date: Date()),
                "originalTimestamp": recipe.timestamp,
                "username": user.username,
                "originalUsername": recipe.username,
                "originalProfileImageUrl": recipe.profileImageUrl,
                "profileImageUrl": user.profileImageUrl]
            
            userSuggestedRef.setData(data) { (_) in
                print("Successfully contributed to recipe")
                userReceivedRef.setData(data) { (_) in
                    print("Successfully received the suggestion")
                }
            }
            
            
        }
        
        func fetchIngredients() -> Array<String> {
            return recipe.ingredients
        }
        
        
        
    }
