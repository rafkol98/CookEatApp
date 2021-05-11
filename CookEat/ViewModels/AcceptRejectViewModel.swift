//
//  AcceptRejectViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 12/04/2021.
//
//  Functions used to accept or reject a contribution received.

import SwiftUI
import Firebase

class AcceptRejectViewModel: ObservableObject {
    let contribution: Contribution
    
    init(contribution: Contribution) {
        self.contribution = contribution
    }
    
    // Accept the received contribution.
    func accept() {
        //Delete the contribution from the receive and update the original recipe.
        COLLECTION_USERS.document(contribution.originalUid).collection("received").document(contribution.id).delete(completion: { _ in
            COLLECTION_RECIPES.document(self.contribution.originalId).updateData([
                "ingredients": self.contribution.suggestedIngredients,
                "instructions": self.contribution.suggestedInstructions
            ]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated")
                }
            }
        })
        
        // Suggested recipe that the user suggested update status to approved.
        COLLECTION_USERS.document(contribution.uid).collection("suggested").document(contribution.id).updateData([
            "status": "Approved",
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    
    // Reject the received contribution.
    func reject() {
        //Delete the contribution from the receive and update the original recipe.
        COLLECTION_USERS.document(contribution.originalUid).collection("received").document(contribution.id).delete(completion: { _ in
            COLLECTION_USERS.document(self.contribution.uid).collection("suggested").document(self.contribution.id).updateData([
                "status": "Rejected",
            ]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated")
                }
            }
        })
    }
    
    
}
