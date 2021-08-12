//
//  VersionControlViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 24/07/2021.
//

import SwiftUI
import Firebase

class VersionControlViewModel: ObservableObject {
    
    let recipe: Recipe
    @Published var contributions = [Contribution]()
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    func fetchVersions() {
        // Fetch recipes of only the users we are following.
        COLLECTION_RECIPES.document(recipe.id).collection("history").order(by: "timestamp", descending: true).addSnapshotListener { (querySnapshot, error) in
            print("I am here")
            self.contributions = []
            //Catch error.
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                // Append versions of documents.
                for document in querySnapshot!.documents {
                    self.contributions.append(Contribution(dictionary: document.data()))
                }
            }
        }
    }
}
