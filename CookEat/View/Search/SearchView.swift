//
//  SearchView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 01/03/2021.
//
//  SearchView used for searching recipes and profiles.


import SwiftUI


struct SearchView: View {
    @State var searchText = ""
    @State var selectedFilter: FilterOptions2 = .one
    @ObservedObject var viewModel = SearchViewModel()
    
    
    var body: some View {
        
        ScrollView {
            TitleView(text: "Search", iconName: "magnifyingglass")
            SearchBar(text: $searchText).padding()
            FilterButtonView2(selectedOption: $selectedFilter)
            
            switch selectedFilter {
            
            // Case two is users profiles.
            case .two:
                VStack(alignment: .leading) {
                    
                    // Loop through users.
                    let users = viewModel.users
                    ForEach(users.filter({"\($0)".contains(searchText) || searchText.isEmpty})) { user in
                        HStack {Spacer()}
                        
                        NavigationLink(
                            destination: LazyView(UserProfileView(user: user)),
                            label: {
                                // Place user in a userCell.
                                UserCell(user: user)
                            })
                    }
                }.padding(.leading)
            
            // Recipes.
            default:
                VStack(alignment: .leading) {
                    // Loop through recipes.
                    let recipes = viewModel.recipes
                    ForEach(recipes.filter({"\($0)".contains(searchText) || searchText.isEmpty})) { recipe in
                        HStack {Spacer()}
                        
                        NavigationLink(
                            destination: RecipeDetailsView(recipe: recipe),
                            label: {
                                // Place user in a userCell.
                                RecipeCell(recipe: recipe)
                            }).foregroundColor(.black)
                    }
                }.padding(.leading)
            }
            
            
            
        }.onAppear {
            // fetch recipes and users.
            self.viewModel.fetchUsers()
            self.viewModel.fetchRecipes()
        }
        
    }
}

