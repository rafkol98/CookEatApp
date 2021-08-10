//
//  Settings.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 24/03/2021.
//
//  View displaying settings/account tab.

import SwiftUI
import Kingfisher


struct Settings: View {
    
    // Get environmentObject of whether user is logged in.
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        ScrollView{
            // If cant find current user show the error message.
            if viewModel.user == nil {
                SettingErrorView()
            } else {
                VStack {
                    VStack{
                        KFImage(URL(string: viewModel.user!.profileImageUrl))
                                                    .resizable()
                                                    .circularImg()
                        
                        Text("@\(viewModel.user!.username)")
                            .font(.system(size: 22, weight:.semibold))
                    }
                    .padding()
                    
                    NavigationLink (
                        destination: UserProfileView(user: viewModel.user!),
                        label: {
                            SettingsOption(icon: "person.crop.circle", text: "View Profile")
                        })
                        .accessibilityLabel("Profile")
                    
                    NavigationLink (
                        destination: ContributionsView(user: viewModel.user!),
                        label: {
                            SettingsOption(icon: "square.stack.3d.up.fill", text: "Contributions")
                        })
                        .accessibilityLabel("Contributions")
                    
                    NavigationLink (
                        destination: RequestsReceivedView(user: viewModel.user!),
                        label: {
                            SettingsOption(icon: "tray.and.arrow.down.fill", text: "Requests Received")
                        })
                        .accessibilityLabel("Requests")
                    
                    
                    Spacer()
                    
                    // Sign out button.
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("Sign Out")
                            .standardButton()
                        
                    })
                    .accessibilityLabel("Sign Out")
                    
                }.foregroundColor(.black)
                
            }
        }
    }
    
}
