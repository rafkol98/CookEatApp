//
//  ProfileActionButtonView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/03/2021.
//

import SwiftUI

struct ProfileActionButtonView: View {
    let isCurrentUser: Bool
    
    var body: some View {
        if isCurrentUser {
        Button(action: {}, label: {
            Text("Edit Profile")
                .frame(width: 360, height: 40)
                .background(Color.red)
                .foregroundColor(.white)
        })
        .cornerRadius(20)
            
        } else {
            HStack {
                Button(action: {}, label: {
                    Text("Follow")
                        .frame(width: 360, height: 40)
                        .background(Color.red)
                        .foregroundColor(.white)
                })
            }
            .cornerRadius(20)
        }
    }
}

struct ProfileActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileActionButtonView(isCurrentUser: false)
    }
}
