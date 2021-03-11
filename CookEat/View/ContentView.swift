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
            if viewModel.userSession != nil {
                NavigationView {
                    
                    TabView {
                        //                FeedView()
                        //                    .tabItem { Image(systemName: "house")
                        //                        Text("home")
                        //                    }
                        
                        
                        FeedView()
                            .tabItem { Image(systemName: "livephoto")
                                Text("Feed")
                            }
                        
                        SearchView()
                            .tabItem {
                                Image(systemName: "magnifyingglass")
                                Text("Search")
                            }
                        
                        
                    }
                    .accentColor(.red)
                    .navigationBarTitle("Home")
                    .navigationBarTitleDisplayMode(.inline)
                }
            } else {
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

