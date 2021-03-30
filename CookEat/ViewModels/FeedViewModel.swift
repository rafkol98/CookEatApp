//
//  FeedViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 26/03/2021.
//

import SwiftUI
import Firebase

class FeedViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    
    init() {
        fetchRecipes()
    }
    
    
    func fetchRecipes(){
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        
//        Fetch recipes of only the users we are following.
        COLLECTION_USERS.document(userUid).collection("users-following").addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    COLLECTION_RECIPES.whereField("uid", in: [document.documentID]).addSnapshotListener { (querySnaphot, error) in
                        guard let documents = querySnaphot?.documents else { return }
                        
                        self.recipes = documents.map{ (queryDocumentSnapshot) -> Recipe in
                            let data = queryDocumentSnapshot.data()
                            
                            let recipe = Recipe(dictionary: data)
                            return recipe
                        }
                    }
                }
            }
        }
    }
}
