//
//  EditProfileView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 16/04/2021.
//

import SwiftUI

struct EditProfileView: View {
    let user: User
    @State var name: String = ""
    
    var body: some View {
        VStack {
            SmallInput(name: "Username", existingText: user.username, iconName: "textformat", stringIn: $name, valid: !invalid(varIn: user.username, boundary: 50))
            
           Spacer()
            
            Button(action: {
                
            }, label: {
               Text("Edit Profile")
                .standardButton()
            })
        }
        .padding()
    }
}
