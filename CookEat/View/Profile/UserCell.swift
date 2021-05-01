//
//  UserCell.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 02/03/2021.
//
//  User cell displaying a user's profile image, username and name.

import SwiftUI
import Kingfisher

struct UserCell: View {
    let user: User
    
    var body: some View {
        // HStack containing picture of user and their username and full name.
        HStack(spacing: 15) {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 56, height: 56)
                .cornerRadius(28)
            
            // Put username and last name on top of each other.
            VStack(alignment: .leading, spacing: 4){
                Text(user.username)
                    .font(.system(size: 16, weight: .semibold))
                
                Text(user.fullname)
                    .font(.system(size: 14))
            }
            .foregroundColor(.black)
        }
    }
}


