//
//  ContentView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 28/02/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
            // If user is signed in, display the main content.
            if viewModel.userSession != nil {
                NavigationView {
                    
                    TabView {
                        FeedView()
                            .tabItem { Image(systemName: "livephoto")
                                Text("Feed")
                            }
                        
                        SearchView()
                            .tabItem {
                                Image(systemName: "magnifyingglass")
                                Text("Search")
                            }
                        
                        Settings()
                            .tabItem {
                                Image(systemName: "person.crop.circle.fill")
                                Text("Account")
                            }
                        
                    }
                    .accentColor(.red)
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            // If user is not logged in, display the loginView.
            else {
                LoginView()
            }
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

