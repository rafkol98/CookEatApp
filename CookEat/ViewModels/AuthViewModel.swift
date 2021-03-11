//
//  AuthViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 11/03/2021.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    
    func login() {
        
    }
    
    func registerUser(email: String, password: String, username: String, fullname: String, profileImage: UIImage) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error \(error.localizedDescription)")
                return
            }
            
            print("Signed up user...")
            
        }
    }
    
    
    
}
