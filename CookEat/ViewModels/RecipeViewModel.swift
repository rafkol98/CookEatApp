//
//  RecipeViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 28/03/2021.
//
//  ViewModel containing all the functions associated with interacting with a recipe.

import SwiftUI
import Firebase

class RecipeViewModel: ObservableObject {
    let recipe: Recipe
    @Published var didLike = false
    
    
    init(recipe: Recipe) {
        self.recipe = recipe
        checkIfUserLiked()
    }
    
    // Like a recipe.
    func likeRecipe() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let recipeLikesRef = COLLECTION_RECIPES.document(recipe.id).collection("recipe-likes")
        let userLikesRef = COLLECTION_USERS.document(uid).collection("user-likes")
        
        // Increment the likes counter and set the uid of the current user as a child in the recipe-likes document.
        COLLECTION_RECIPES.document(recipe.id).updateData(["likes": recipe.likes + 1 ]){ _ in
            recipeLikesRef.document(uid).setData([:]) { _ in
                // Add the recipe id under the "user-likes" document.
                userLikesRef.document(self.recipe.id).setData([:]) { _ in
                    self.didLike = true
                }
            }
        }
        
    }
    
    // Unlike a recipe
    func unlikeRecipe() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let recipeLikesRef = COLLECTION_RECIPES.document(recipe.id).collection("recipe-likes")
        let userLikesRef = COLLECTION_USERS.document(uid).collection("user-likes")
        
        // Update likes counter of recipe.
        COLLECTION_RECIPES.document(recipe.id).updateData(["likes": recipe.likes - 1]){ _ in
            // Delete the like association of user with the recipe.
            recipeLikesRef.document(uid).delete { _ in
                userLikesRef.document(self.recipe.id).delete { _ in
                    self.didLike = false
                }
            }
        }
    }
    
    // Check if user liked a recipe.
    func checkIfUserLiked() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let userLikesRef = COLLECTION_USERS.document(uid).collection("user-likes").document(recipe.id)
        
        userLikesRef.addSnapshotListener { snapshot, _ in
            guard let didLike = snapshot?.exists else { return }
            self.didLike = didLike
        }
    }
    
    // Edit a recipe.
    func edit(name: String, description: String, ingredients: Array<String>, instructions: Array<String>) {
        
        //Validation of updated data.
        if (!invalid(varIn: name, minBoundary: 5, maxBoundary: 50) && !invalid(varIn: description, minBoundary: 10, maxBoundary: 1000) && !invalidArray(varIn: ingredients) && !invalidArray(varIn: instructions)) {
            
            COLLECTION_RECIPES.document(recipe.id).updateData([
                "recipeName": name,
                "description": description,
                "ingredients": ingredients,
                "instructions": instructions
            ]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated")
//
//                    // TODO: VERSION CONTROL - have to have addedIngredients, suggested, removed etc.
//
//
//
//                    // Set initial commit to history.
//                    let versionControlRef = COLLECTION_RECIPES.document(recipe.id).collection("history").document()
//
//
//                    let data : [String: Any] = ["uid": recipe.uid,
//                                                    "id": recipe.id,
//                                                    "recipeName": recipe.recipeName,
//                                                    "description": recipe.,
//                                                    "addedIngredients": ingredients,
//                                                    "addedInstructions": instructions,
//                                                    "suggestedIngredients": ingredients,
//                                                    "suggestedInstructions": instructions,
//                                                    "fullname": user.fullname,
//                                                    "timestamp": Timestamp(date: Date()),
//                                                    "username": user.username,
//                                                    "profileImageUrl": user.profileImageUrl,
//                                                    "status": "Initial Commit"
//                        ]
//
//                        versionControlRef.setData(data)
                }
            }
        }
        
    }
    
    // Delete the recipe.
    func deleteRecipe() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let receivedRef = COLLECTION_USERS.document(uid).collection("received")
        
        COLLECTION_RECIPES.document(recipe.id).delete { _ in
            receivedRef.whereField("originalId", in: [self.recipe.id]).addSnapshotListener { (snapshot, error) in
                if let snapshot = snapshot?.documents {
                    for document in snapshot {
                        //create a temporary contribution object
                        let temp = Contribution(dictionary: document.data())
                        
                        //Delete all the received contributions
                        receivedRef.document(document.documentID).delete() { error in
                            if let error = error {
                                print("Error deleting document: \(error)")
                            } else {
                                //delete the suggested contirbution sent by another user.
                                COLLECTION_USERS.document(temp.uid).collection("suggested").document(document.documentID).delete() { error in
                                    if let error = error {
                                        print("Error deleting document: \(error)")
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
    
    //Fork recipe.
    func forkRecipe() {
        guard let user = AuthViewModel.shared.user else {return}
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_RECIPES.document(recipe.id).addSnapshotListener { snapshot, _ in
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
            
            docRef.setData(data) {  error in
                if let error = error {
                    print("Error forking reecipe: \(error)")
                } else {
                    print("Documents successfully forked")
                    
                    // Fetch history-version control.
                    COLLECTION_RECIPES.document(self.recipe.id).collection("history").getDocuments { snapshot, _ in
                        
                        guard let documents = snapshot?.documents else { return }
                        let historyIDs = documents.map({$0.documentID})
                        
                        historyIDs.forEach { id in
                            COLLECTION_RECIPES.document(self.recipe.id).collection("history").document(id).getDocument { snapshot, error in
                                // Catch error.
                                if let error = error {
                                    print("Failed to fetch liked recipes: \(error.localizedDescription)")
                                    return
                                }
                                guard let data = snapshot?.data() else { return }
                                docRef.collection("history").addDocument(data: data)
                            }
                        }
                        
                    }
                    
                }
            }
        }
    }
    
    // Contribute to a recipe.
    func contributeRecipe(addedIngredients: Array<String>, addedInstructions: Array<String>, removedIngredients: Array<String>, removedInstructions: Array<String>, suggestedIngredients: Array<String>, suggestedInstructions: Array<String>) {
        
        //Validation that the suggested ingredients & instructions are not empty (user deleted all elements).
        if ( !invalidArray(varIn: suggestedIngredients) && !invalidArray(varIn: suggestedInstructions)) {
            
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
                "profileImageUrl": user.profileImageUrl,
                "reverted": false]
            
            userSuggestedRef.setData(data) { (_) in
                print("Successfully contributed to recipe")
                userReceivedRef.setData(data) { (_) in
                    print("Successfully received the suggestion")
                }
            }
        }
        
    }
    
}
