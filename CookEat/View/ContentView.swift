//
//  ContentView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 28/02/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        //       Bottom Navigation
        NavigationView {
            
            TabView {
                FeedView()
                    .tabItem { Image(systemName: "house")
                        Text("home")
                    }

                
                FeedView()
                    .tabItem { Image(systemName: "livephoto")
                        Text("Feed")
                    }
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                
                ConversationsView()
                    .tabItem { Image(systemName: "envelope")
                        Text("Messages")
                    }
            }
            .accentColor(.red)
            .navigationBarTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
