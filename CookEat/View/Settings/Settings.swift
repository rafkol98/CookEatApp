//
//  Settings.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 24/03/2021.
//

import SwiftUI
import Kingfisher


struct Settings: View {
    
    //    Get environmentObject of whether user is logged in.
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        ScrollView{
            if viewModel.user == nil {
                SettingErrorView()
            } else {
                VStack{
                    HStack{
                        KFImage(URL(string: viewModel.user!.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 120, height: 120)
                            .cornerRadius(120/2)
                            .shadow(radius: 10)
                            .padding()
                        //                        print("meta img")
                        
                        VStack {
                            Text(viewModel.user!.fullname)
                                .font(.system(size: 22, weight: .semibold))
                            Text("@\(viewModel.user!.username)")
                                .font(.system(size: 16))
                        }
                        Spacer()
                        
                    }
                    .padding()
                    
                    
                    NavigationLink(
                        destination: LazyView(UserProfileView(user: viewModel.user!)),
                        label: {
                            SettingsOption(icon: "person.crop.circle", text: "View Profile")
                        })
                    
                    
                    NavigationLink(
                        destination: LazyView(ContributionsView(user: viewModel.user!)),
                        label: {
                            SettingsOption(icon: "square.stack.3d.up.fill", text: "Contributions")
                        })
                    
                    NavigationLink(
                        destination: LazyView(RequestsReceivedView(user: viewModel.user!)),
                        label: {
                            SettingsOption(icon: "tray.and.arrow.down.fill", text: "Requests Received")
                        })
                    
                    
                    Spacer()
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("Sign out")
                            .standardButton()
                        
                    })
                }.foregroundColor(.black)
                
            }
        }
    }
    
}
