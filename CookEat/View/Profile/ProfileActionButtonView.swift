//
//  ProfileActionButtonView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/03/2021.
//

import SwiftUI

struct ProfileActionButtonView: View {
    let viewModel: ProfileViewModel
    @Binding var isFollowed: Bool
    
    var body: some View {
        if viewModel.user.currentUser {
            Button(action: {}, label: {
                Text("Edit Profile")
                .frame(width: 360, height: 40)
                .background(Color.red)
                .foregroundColor(.white)
        })
        .cornerRadius(20)
            
        } else {
            HStack {
                Button(action: {
                    isFollowed ? viewModel.unfollow(): viewModel.follow()
                }, label: {
                    Text(isFollowed ? "Following" : "Follow")
                        .frame(width: 360, height: 40)
                        .background(Color.red)
                        .foregroundColor(.white)
                })
            }
            .cornerRadius(20)
        }
    }
}


