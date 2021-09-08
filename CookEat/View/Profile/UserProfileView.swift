//
//  UserProfileView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/03/2021.
//
//  Used for showing the profile of a user.

import SwiftUI


struct UserProfileView: View {
    
    //Selected filter for the view.
    @State var selectedFilter: FilterOptions = .one
    let user: User
    @ObservedObject var viewModel: ProfileViewModel
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        ScrollView{
            VStack {
                ProfileHeaderView(isFollowed: $viewModel.isFollowed, viewModel: viewModel)
                
                NavigationLink (
                    destination: ContributionsView(user: user),
                    label: {
                        AccountOption(icon: "square.stack.3d.up.fill", text: "Contributions Made")
                    })
                    .accessibilityLabel("Contributions")
                    .foregroundColor(.black)
                    .padding()
                
                FilterButtonView(selectedOption: $selectedFilter)
                    .padding()
                
                
                ForEach(viewModel.recipes(forFilter: selectedFilter)) { recipe in
                    
                    NavigationLink(
                        destination: RecipeDetailsView(recipe: recipe),
                        label: {
                            // Place user in a userCell.
                            RecipeCell(recipe: recipe)
                        })
                        .foregroundColor(.black)
                        .padding()
                    
                }.padding(.horizontal)
                
            }.scaledToFit()
            .onAppear {
                viewModel.fetchUserRecipes()
            }
        }
    }
}
