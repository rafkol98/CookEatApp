//
//  AcceptRejectViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 12/04/2021.
//

import SwiftUI
import Firebase

class AcceptRejectViewModel: ObservableObject {
    let contribution: Contribution
    
    init(contribution: Contribution) {
        self.contribution = contribution
    }
    
    func accept() {
        //Delete the contribution from the receive and update the original recipe.
        COLLECTION_USERS.document(contribution.originalUid).collection("received").document(contribution.id).delete(completion: { _ in
            COLLECTION_RECIPES.document(self.contribution.originalId).updateData([
                "ingredients": self.contribution.suggestedIngredients,
                "instructions": self.contribution.suggestedInstructions
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        })
        
        
        COLLECTION_USERS.document(contribution.uid).collection("suggested").document(contribution.id).updateData([
                "status": 1,
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
   
        
        
    }
    
}
