//
//  SearchViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 14/03/2021.
//

import SwiftUI
import Firebase

class SearchViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    @Published var users = [User]()
    
  
    
    //    Populate users array.
    func fetchUsers() {

        COLLECTION_USERS.addSnapshotListener { snapshot, _ in
            self.users = []
            guard let documents = snapshot?.documents else { return }
            
            documents.forEach { document in
                //                Initialise user with the data returned from firebase.
                let user = User(dictionary: document.data())
                //                append user to user array.
                self.users.append(user)
            }
        }
    }
    
    func fetchRecipes() {
     
        COLLECTION_RECIPES.addSnapshotListener { (querySnaphot, error) in
            self.recipes = []
            guard let documents = querySnaphot?.documents else { return }
            
            documents.forEach { document in
                //                Initialise user with the data returned from firebase.
                let recipe = Recipe(dictionary: document.data())
                //                append user to user array.
                self.recipes.append(recipe)
            }
        }
    }

    
}
