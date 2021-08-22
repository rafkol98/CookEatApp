//
//  SettingsView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 13/08/2021.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var changePassword = false
    @State private var changeEmail = false
    @State private var deleteAccount = false
    
    
    var body: some View {
        VStack {
            
            TitleView(text: "Settings", iconName: "gear")
            Divider()
            
            Button(action: {
                // Toggle flag to open sheet.
               changeEmail.toggle()
            }) {
                AccountOption(icon: "envelope", text: "Change Email")
                    .foregroundColor(.black)
            }
            .sheet(isPresented: $changeEmail, content: {
                ChangeEmailView()
            })
            
            Button(action: {
                // Toggle flag to open sheet.
               changePassword.toggle()
            }) {
                AccountOption(icon: "ellipsis.rectangle", text: "Change Password")
                    .foregroundColor(.black)
            }
            .sheet(isPresented: $changePassword, content: {
                ChangePasswordView()
            })
                        
            Button(action: {
                // Toggle flag to open sheet.
               deleteAccount.toggle()
            }) {
                AccountOption(icon: "delete.right.fill", text: "Delete Account")
                    .foregroundColor(.red)
            }
            .sheet(isPresented: $deleteAccount, content: {
                ChangePasswordView()
            })
            
            Spacer()
            
        }
    }
}
