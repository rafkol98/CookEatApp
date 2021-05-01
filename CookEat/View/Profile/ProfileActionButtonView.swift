//
//  ProfileActionButtonView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/03/2021.
//
//  Action button shown in profile.

import SwiftUI

struct ProfileActionButtonView: View {
    let viewModel: ProfileViewModel
    @Binding var isFollowed: Bool
    
    var body: some View {
        // Only display button if the profile does not belong to the current user.
        if !viewModel.user.currentUser {
            HStack {
                Button(action: {
                    //If they are not following the user -> follow them. If they are following them -> unfollow them.
                    isFollowed ? viewModel.unfollow(): viewModel.follow()
                }, label: {
                    Text(isFollowed ? "Following" : "Follow")
                        .standardButton()
                })
            }
            .cornerRadius(20)
        }
    }
}


