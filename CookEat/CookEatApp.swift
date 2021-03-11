//
//  CookEatApp.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 28/02/2021.
//

import SwiftUI
import Firebase

@main
struct CookEatApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel())
            
            
            LoginView()
//            ContentView()
        }
    }
}
