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
    
    func checkIfUserLiked() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let userLikesRef = COLLECTION_USERS.document(uid).collection("user-likes").document(recipe.id)
        
        userLikesRef.getDocument { snapshot, _ in
            guard let didLike = snapshot?.exists else { return }
            self.didLike = didLike
        }
        
    }
    
}
