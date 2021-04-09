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
    @Published var suggestedRecipes = [Suggested]()
    
    init(recipe: Recipe) {
        self.recipe = recipe
        checkIfUserLiked()
    }
    
//    Like a recipe.
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
    
    //bug goes -1.
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
        
        userLikesRef.getDocument { snapshot, _ in
            guard let didLike = snapshot?.exists else { return }
            self.didLike = didLike
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
    
    //TODO: added ingredients and instructions
    func contributeRecipe(addedIngredients: Array<String>, addedInstructions: Array<String>, removedIngredients: Array<String>, removedInstructions: Array<String>) {
        guard let user = AuthViewModel.shared.user else {return}
        
        let recipeSuggestedRef = COLLECTION_RECIPES.document(recipe.id).collection("Suggested").document()
        
        let data : [String: Any] = ["id": recipeSuggestedRef.documentID,
                                    "uid": user.id,
                                    "addedIngredients": addedIngredients,
                                    "addedInstructions": addedInstructions,
                                    "removedIngredients": removedIngredients,
                                    "removedInstructions": removedInstructions,
                                    "fullname": user.fullname,
                                    "timestamp": Timestamp(date: Date()),
                                    "username": user.username,
                                    "profileImageUrl": user.profileImageUrl]
        
        recipeSuggestedRef.setData(data) { (_) in
            print("Successfully contributed to recipe")
        }
        
        
    }
    
    func fetchIngredients() -> Array<String> {
        return recipe.ingredients
    }
    
    //Fetch recipes of the user.
    func fetchSuggestedRecipes() {
        guard let user = AuthViewModel.shared.user else {return}
        
        COLLECTION_RECIPES.whereField("uid", isEqualTo: user.id).addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let userRecipes = documents.map({ Recipe(dictionary: $0.data()) })
            
            userRecipes.forEach { recipe in
                let docRef = COLLECTION_RECIPES.document(recipe.id).collection("Suggested")
                
                docRef.getDocuments { (document, error) in
                    if document != nil {
                        let suggested = document?.documents
                        suggested?.forEach { recipe in
                            let sugRecipe = Suggested(dictionary: recipe.data())
                            print(sugRecipe)
                            self.suggestedRecipes.append(sugRecipe)
                       
                        }
                    
                    }
                }

                
            }
        
        }
    }
    
}
