//
//  SuggestedViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 10/04/2021.
//

import Foundation
import SwiftUI
import Firebase

class SuggestedViewModel: ObservableObject {
    
    let user: User
    @Published var suggestedRecipes = [Suggested]()
    
    init(user: User) {
        self.user = user
        fetchSuggestedRecipes()
    }
    
    
    //Fetch recipes of the user.
    func fetchSuggestedRecipes() {
    
        COLLECTION_RECIPES.whereField("uid", isEqualTo: user.id).addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let userRecipes = documents.map({ Recipe(dictionary: $0.data()) })
            print(userRecipes)
            
            userRecipes.forEach { recipe in
                let docRef = COLLECTION_RECIPES.document(recipe.id).collection("Suggested")
                
                docRef.getDocuments { (document, error) in
                    if document != nil {
                        let suggested = document?.documents
                        suggested?.forEach { recipe in
                            let sugRecipe = Suggested(dictionary: recipe.data())
                            self.suggestedRecipes.append(sugRecipe)
                       
                        }
                    
                    }
                }

                
            }
        
        }
    }
}
