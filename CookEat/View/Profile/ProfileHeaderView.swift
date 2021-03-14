//
//  ProfileHeaderView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/03/2021.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    let user: User
    
    var body: some View {
        VStack {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 120, height: 120)
                .cornerRadius(120/2)
                .shadow(radius: 10)
            
            Text(user.fullname)
                .font(.system(size: 16, weight:.semibold))
                .padding(.top, 8)
            
            Text("@\(user.username)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack(spacing: 40) {
                VStack {
                    Text("10")
                        .font(.system(size: 16)).bold()
                    
                    Text("Followers")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                }
                
                VStack {
                    Text("12")
                        .font(.system(size: 16)).bold()
                    
                    Text("Following")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                }
            }
            .padding()
            
            ProfileActionButtonView(isCurrentUser: user.currentUser)
            
            Spacer()
        }
    }
}
