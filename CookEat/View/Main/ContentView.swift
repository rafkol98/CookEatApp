//
//  ContentView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 28/02/2021.
//
//  Manages the content displayed to the user.

import SwiftUI
import Kingfisher


struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var openSettings = false
    
    var body: some View {
        Group {
            // If user is signed in, display the main content.
            if viewModel.userSession != nil {
                
                // Bottom navigation.
                NavigationView {
                    
                    TabView {
                        FeedView()
                            .tabItem {
                                Image(systemName: "livephoto")
                                Text("Feed")
                            }
                        
                        SearchView()
                            .tabItem {
                                Image(systemName: "magnifyingglass")
                                Text("Search")
                            }
                        
                        
                        AccountView()
                            .tabItem {
                                Image(systemName: "person.crop.circle.fill")
                                Text("Account")
                            }
                        
                    }
                    
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading: Button(action: {
                        
                    }, label: {
                        if let user = viewModel.user {
                            KFImage(URL(string: user.profileImageUrl ))
                                .resizable()
                                .scaledToFill()
                                .clipped()
                                .frame(width: 32, height: 32)
                                .cornerRadius(16)
                        }
                    }))
                    
                    .toolbar(content: {

                        ToolbarItem(placement: .navigationBarTrailing) {
                            
                            NavigationLink (
                                destination: SettingsView(),
                                label: {
                                    Image(systemName: "gear")
                                      .font(Font.title.weight(.light))
                                }
                            )
                            
//                            Button(action: {
//                                openSettings.toggle()
//                            }, label: {
//                                Image(systemName: "gear")
//                                  .font(Font.title.weight(.light))
//                            }).sheet(isPresented: $openSettings, content: {
//                                //Open SettingsView
//                                SettingsView()
//                            })
                        }

                    })
                    
                }
                .accentColor(.red)
                .accessibility(identifier: "Nav")
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

