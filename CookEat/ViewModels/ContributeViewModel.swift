//
//  SuggestedViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 10/04/2021.
//

import Foundation
import SwiftUI
import Firebase

class ContributeViewModel: ObservableObject {
    
    let user: User
    @Published var receivedRecipes = [Suggested]()
    @Published var contributedRecipes = [Suggested]()
    
    init(user: User) {
        self.user = user
        fetchReceivedRecipes()
        fetchSuggestedRecipes()
    }
    
    
    //Fetch recipes of the user.
    func fetchReceivedRecipes() {
        
        COLLECTION_USERS.document(user.id).collection("received").addSnapshotListener { (querySnaphot, error) in
            guard let documents = querySnaphot?.documents else { return }
            
            self.receivedRecipes = documents.map{ (queryDocumentSnapshot) -> Suggested in
                let data = queryDocumentSnapshot.data()
                
                let recipe = Suggested(dictionary: data)
                return recipe
            }
        }
    }
    
    //Fetch recipes of the user.
    func fetchSuggestedRecipes() {
        
        COLLECTION_USERS.document(user.id).collection("suggested").addSnapshotListener { (querySnaphot, error) in
            guard let documents = querySnaphot?.documents else { return }
            
            self.contributedRecipes = documents.map{ (queryDocumentSnapshot) -> Suggested in
                let data = queryDocumentSnapshot.data()
                
                let recipe = Suggested(dictionary: data)
                return recipe
            }
        }
    }
}
