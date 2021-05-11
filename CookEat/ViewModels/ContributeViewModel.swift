//
//  SuggestedViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 10/04/2021.
//
//  ViewModel used for fetching contributions sent and received.

import Foundation
import SwiftUI
import Firebase

class ContributeViewModel: ObservableObject {
    
    let user: User
    @Published var receivedRecipes = [Contribution]()
    @Published var contributedRecipes = [Contribution]()
    
    init(user: User) {
        self.user = user
        fetchReceivedRecipes()
        fetchSuggestedRecipes()
    }
    
    
    // Fetch contributions that the user received.
    func fetchReceivedRecipes() {
        
        COLLECTION_USERS.document(user.id).collection("received").addSnapshotListener { (querySnaphot, error) in
            // Catch error.
            if let error = error {
                print("Failed to upload image \(error.localizedDescription)")
                return
            }
            guard let documents = querySnaphot?.documents else { return }
            
            // Assign received contributions to the receivedRecipes.
            self.receivedRecipes = documents.map{ (queryDocumentSnapshot) -> Contribution in
                let data = queryDocumentSnapshot.data()
                
                let recipe = Contribution(dictionary: data)
                return recipe
            }
        }
    }
    
    // Fetch contributions that the user sent.
    func fetchSuggestedRecipes() {
        
        COLLECTION_USERS.document(user.id).collection("suggested").addSnapshotListener { (querySnaphot, error) in
            // Catch error.
            if let error = error {
                print("Failed to upload image \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnaphot?.documents else { return }
            
            // Assign contributions to the contributedRecipes.
            self.contributedRecipes = documents.map{ (queryDocumentSnapshot) -> Contribution in
                let data = queryDocumentSnapshot.data()
                
                let recipe = Contribution(dictionary: data)
                return recipe
            }
        }
    }
}
