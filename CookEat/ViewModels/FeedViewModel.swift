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
//        COLLECTION_RECIPES.getDocuments { snapshot, _ in
//            guard let documents = snapshot?.documents else { return }
//
//            self.recipes = documents.map({ Recipe(dictionary: $0.data()) })
//        }
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        let following_ref = COLLECTION_FOLLOWING.document(userUid).collection("user-following")
        following_ref.getDocuments { snapshot, _ in
            guard let following = snapshot?.documents else { return }
            print(following)
            
            COLLECTION_RECIPES.addSnapshotListener { (querySnaphot, error) in
                guard let documents = querySnaphot?.documents else { return }
                
                self.recipes = documents.map{ (queryDocumentSnapshot) -> Recipe in
                    let data = queryDocumentSnapshot.data()
                    let uid = data["uid"]
                    
                
                    print(uid ?? "no")
                    let recipe = Recipe(dictionary: data)
                    return recipe
                }
                
            }
            
        }
        
        
    }
}
