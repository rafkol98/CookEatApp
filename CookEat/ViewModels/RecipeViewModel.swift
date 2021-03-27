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
    }
    
    func likeRecipe() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let recipeLikesRef = COLLECTION_RECIPES.document(recipe.id).collection("recipe-likes")
        let userLikesRef = COLLECTION_RECIPES.document(recipe.id).collection("user-likes")
        
        COLLECTION_RECIPES.document(recipe.id).updateData(["likes":recipe.likes+1]) { _ in
            recipeLikesRef.document(uid).setData([:]) { _ in
                userLikesRef.document(self.recipe.id).setData([:]) { _ in
                    self.didLike = true
                }
            }
        }
        
        
    }
    
}
