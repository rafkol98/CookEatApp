//
//  UserProfileView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/03/2021.
//

import SwiftUI

// Used for showing the profile of a user.
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
                    .padding()
                
                FilterButtonView(selectedOption: $selectedFilter)
                    .padding()
                
                // Switch between user's own recipes and their likes.
                ForEach(viewModel.recipes(forFilter: selectedFilter)) { recipe in
                    
                    NavigationLink(
                        destination: LazyView(RecipeDetailsView(recipe: recipe)),
                        label: {
                            // Place user in a userCell.
                            RecipeCell(recipe: recipe)
                        })
                        .foregroundColor(.black)
                        .padding()
                    
                }.padding(.horizontal)
                
            }.scaledToFit()
        }
    }
}
