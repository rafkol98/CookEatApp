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
            let data : [String: Any] = [
                "id": self.contribution.id,
                "status": "Approved",
                "originalId": self.contribution.originalId,
                "uid": self.contribution.uid,
                "originalUid": self.contribution.originalUid,
                "recipeName": self.contribution.recipeName,
                "addedIngredients": self.contribution.addedIngredients,
                "addedInstructions": self.contribution.addedInstructions,
                "removedIngredients": self.contribution.removedIngredients,
                "removedInstructions": self.contribution.removedInstructions,
                "originalIngredients": self.contribution.originalIngredients,
                "originalInstructions": self.contribution.originalInstructions,
                "suggestedIngredients": self.contribution.suggestedIngredients,
                "suggestedInstructions": self.contribution.suggestedInstructions,
                "fullname": self.contribution.fullname,
                "originalFullname": self.contribution.originalFullname,
                "timestamp": self.contribution.timestamp,
                "originalTimestamp": self.contribution.originalTimestamp,
                "username": self.contribution.username,
                "originalUsername": self.contribution.originalUsername,
                "originalProfileImageUrl": self.contribution.originalProfileImageUrl,
                "profileImageUrl": self.contribution.profileImageUrl
            ]
            
            COLLECTION_RECIPES.document(self.contribution.originalId).updateData([
                "ingredients": self.contribution.suggestedIngredients,
                "instructions": self.contribution.suggestedInstructions
            ]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    // Store history of contribution - version control.
                    COLLECTION_RECIPES.document(self.contribution.originalId).collection("history").document(self.contribution.id).setData(data)
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
    
    func revertChanges() {
        // 1. Set in main recipe  2. set in history again
        COLLECTION_RECIPES.document(self.contribution.originalId).updateData([
            "ingredients": self.contribution.suggestedIngredients,
            "instructions": self.contribution.suggestedInstructions
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                // Store history of contribution - version control.
                COLLECTION_RECIPES.document(self.contribution.originalId).collection("history").document(self.contribution.id).updateData([
                    "timestamp":  Timestamp(date: Date())
                ])
                print("Document successfully updated")
            }
        }
        
//        COLLECTION_RECIPES.document(self.contribution.originalId).collection("history").document(self.contribution.id).setData(data)
    }
    
    
}
