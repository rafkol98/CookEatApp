//
//  FeedViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 26/03/2021.
//
//  ViewModel used on the feed view of the app.

import SwiftUI
import Firebase

class FeedViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    
    init() {
        fetchRecipes()
    }
    
    // fetch recipes of only followed users.
    func fetchRecipes(){
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        
        // Fetch recipes of only the users we are following.
        COLLECTION_USERS.document(userUid).collection("users-following").addSnapshotListener { (querySnapshot, error) in
            self.recipes = []
            //Catch error.
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    //look for recipes only where uid equals the current document returned from the querySnapshot above.
                    COLLECTION_RECIPES.whereField("uid", in: [document.documentID]).addSnapshotListener { (querySnaphot, error) in
                        
                        //Catch error.
                        if let error = error {
                            print("Failed to upload image \(error.localizedDescription)")
                            return
                        }
                        
                        guard let documents = querySnaphot?.documents else { return }
                        
                        // Append recipe to the user's recipes variable.
                        self.recipes.append( contentsOf: documents.map{ (queryDocumentSnapshot) -> Recipe in
                            let data = queryDocumentSnapshot.data()
                            
                            let recipe = Recipe(dictionary: data)
                            return recipe
                        })
                    }
                }
            }
        }
    }
    
}
