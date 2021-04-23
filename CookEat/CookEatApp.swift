//
//  CookEatApp.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 28/02/2021.
//

import SwiftUI
import Firebase
import Sentry

@main
struct CookEatApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
            
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        SentrySDK.start { options in
            options.dsn = "https://c5681a814f534878be914a0067660399@o577693.ingest.sentry.io/5733824"
            options.debug = true // Enabled debug when first installing is always helpful
        }

        return true
    }
}
