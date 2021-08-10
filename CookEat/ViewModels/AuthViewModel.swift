//
//  AuthViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 11/03/2021.
//
//  ViewModel containing all the functions associated with user authentication.

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    // Logged in variable.
    @Published var userSession: FirebaseAuth.User?
    @Published var isAuthenticating = false
    // Message to the user.
    @Published var error: Error?
    @Published var user: User?
    
    // Static variable to be able to access user from every screen without reinitializing AuthViewModel every time.
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    // Login user.
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            // attach user to the user session.
            self.userSession = result?.user
            self.fetchUser()
        }
    }
    
    // Register new user.
    func registerUser(email: String, password: String, username: String, fullname: String, profileImage: UIImage) {
        
        // Check if input is valid.
        if (isValidEmail(email: email) && !invalid(varIn: password, minBoundary: 6, maxBoundary: 40) && !invalid(varIn: username, minBoundary: 5, maxBoundary: 20) && !invalid(varIn: fullname, minBoundary: 5, maxBoundary: 50)) {
            
            guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
            let filename = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child(filename)
            
            // Put image to firebase storage.
            storageRef.putData(imageData, metadata: nil) { _, error in
                if let error = error {
                    print("Failed to upload image \(error.localizedDescription)")
                    return
                }
                // Get an image url for the picture.
                storageRef.downloadURL { url, _ in
                    guard let profileImageUrl = url?.absoluteString else { return }
                    
                    Auth.auth().createUser(withEmail: email, password: password) { result, error in
                        // Print error
                        if let error = error {
                            print("Error \(error.localizedDescription)")
                            return
                        }
                        
                        // Check if user exists.
                        guard let user = result?.user else { return }
                        
                        let data : [String : Any] = ["email": email, "username": username.lowercased(), "fullname": fullname, "profileImageUrl": profileImageUrl, "uid": user.uid]
                        
                        Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                            self.userSession = user
                            self.fetchUser()
                        }
                    }
                }
            }
        } else {
            print("invalid")
        }
    }
    
    // Sign out of the application.
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
    
    // Fetch current user.
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        //Get user from firestore and place them in a User variable.
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Failed to fetch user: \(error.localizedDescription)")
                return
            }
            
            guard let data = snapshot?.data() else { return }
            self.user = User(dictionary: data)
        } 
    }
    
    
    
    
}
