//
//  SettingsViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 16/08/2021.
//

import SwiftUI
import Firebase

class SettingsViewModel: ObservableObject {
    
    init() {
    }
    
    // Change password of user.
    func changePassword(currentPassword: String, newPassword: String, confirmPassword: String) {
        if !currentPassword.isEmpty || !newPassword.isEmpty || !confirmPassword.isEmpty {
            
            if invalid(varIn: newPassword, minBoundary: 6, maxBoundary: 40) {
                if equalString(stringOne: newPassword, stringTwo: confirmPassword) {
                    let user = Auth.auth().currentUser
                    let credential: AuthCredential = EmailAuthProvider.credential(withEmail: (user?.email)!, password: currentPassword)
                    
                    user?.reauthenticate(with: credential, completion: { (_, error) in
                        if let error = error {
                            // An error happened.
                            print("Error reauthenticating: %@", error)
                        } else {
                            // User re-authenticated.
                            Auth.auth().currentUser?.updatePassword(to: newPassword, completion: { (error) in
                                if let error = error {
                                    // An error happened.
                                    print("Error updating password: %@", error)
                                } else {
                                    print("successfully updated password")
                                }
                            })
                        }
                    })
                    
                }
            }
        }
    }
    
}