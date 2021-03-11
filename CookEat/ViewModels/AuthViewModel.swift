//
//  AuthViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 11/03/2021.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
//    Logged in variable.
    @Published var userSession: FirebaseAuth.User?
    @Published var isAuthenticating = false
//    Message to the user.
    @Published var error: Error?
    @Published var user: User?
    
//    If logged in, show the main screen.
    init() {
        userSession = Auth.auth().currentUser
    }
    
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            print("Logged in...")
        }
    }
    
    //    Register new user.
    func registerUser(email: String, password: String, username: String, fullname: String, profileImage: UIImage) {
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child(filename)
        
        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("Failed to upload image \(error.localizedDescription)")
                return
            }
            // Get an image url for the picture.
            storageRef.downloadURL { url, _ in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    //            Print error
                    if let error = error {
                        print("Error \(error.localizedDescription)")
                        return
                    }
                    
                    guard let user = result?.user else { return }
                    
                    let data = ["email": email, "username": username, "fullname": fullname, "profileImageUrl": profileImageUrl, "uid": user.uid]
                    
                    Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                        print("Successfully uploaded user data")
                    }
                }
            }
            
        }
    }
    
    
    
}
