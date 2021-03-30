//
//  UserProfileView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/03/2021.
//

import SwiftUI

struct UserProfileView: View {
    @State var selectedFilter: FilterOptions = .recipes
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
                
                ForEach(viewModel.recipes(forFilter: selectedFilter)) { recipe in
                    RecipeCell(recipe: recipe)
                        .padding()
                }.padding(.horizontal)
            }
            
            
            
        }
    }
}
