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


