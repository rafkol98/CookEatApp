//
//  ProfileHeaderView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/03/2021.
//
//  The header view of the profile.

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    
    @Binding var isFollowed: Bool
    let viewModel: ProfileViewModel
    
    
    var body: some View {
        VStack {
            KFImage(URL(string: viewModel.user.profileImageUrl))
                .resizable()
                .circularImg()
            
            Text(viewModel.user.fullname)
                .font(.system(size: 16, weight:.semibold))
                .padding(.top, 8)
            
            Text("@\(viewModel.user.username)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            // Followers and following counters.
            HStack(spacing: 40) {
                VStack {
                    Text("\(viewModel.followers)")
                        .font(.system(size: 16)).bold()
                    
                    Text("Followers")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                
                VStack {
                    Text("\(viewModel.following)")
                        .font(.system(size: 16)).bold()
                    
                    Text("Following")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                }
            }
            .padding()
            
            // Include button which changes from follow to following depending if the current user is following the displayed user.
            ProfileActionButtonView(viewModel: viewModel, isFollowed: $isFollowed)
            
            Spacer()
        }
    }
}
