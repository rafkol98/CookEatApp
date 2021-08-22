//
//  SettingsView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 13/08/2021.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            
            TitleView(text: "Settings", iconName: "gear")
            
            Divider()
            
            NavigationLink (
                destination: ChangePasswordView(),
                label: {
                    AccountOption(icon: "ellipsis.rectangle", text: "Change Password")
                }
            )
            
            NavigationLink (
                destination: FeedView(),
                label: {
                    AccountOption(icon: "person.crop.circle.badge.questionmark", text: "Change Username")
                }
            )
            
            NavigationLink (
                destination: FeedView(),
                label: {
                    AccountOption(icon: "delete.right.fill", text: "Delete Account")
                }
            )
            
            
            
            Spacer()
            
        }.foregroundColor(.black)
    }
}
