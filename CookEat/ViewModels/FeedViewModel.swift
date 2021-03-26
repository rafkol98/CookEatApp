//
//  FeedViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 26/03/2021.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    
    init() {
        fetchRecipes()
    }
    
    func fetchRecipes(){
        COLLECTION_RECIPES.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.recipes = documents.map({ Recipe(dictionary: $0.data()) })
        }
    }
}
