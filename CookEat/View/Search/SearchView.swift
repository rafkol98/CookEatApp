//
//  SearchView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 01/03/2021.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @State var selectedFilter: FilterOptions = .one
    @ObservedObject var searchViewModel = SearchViewModel()
    
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText).padding()
            FilterButtonView(selectedOption: $selectedFilter)
            
            switch selectedFilter {
            case .two:
                VStack(alignment: .leading) {
    //                Loop through users.
                    let users = searchViewModel.users
                    ForEach(users.filter({"\($0)".contains(searchText) || searchText.isEmpty})) { user in
                        HStack {Spacer()}
    
                        NavigationLink(
                            destination: LazyView(UserProfileView(user: user)),
                            label: {
    //                            Place user in a userCell.
                                UserCell(user: user)
                            })
                    }
                }.padding(.leading)
            default:
                VStack(alignment: .leading) {
                    //                Loop through users.
                    let recipes = searchViewModel.recipes
                    ForEach(recipes.filter({"\($0)".contains(searchText) || searchText.isEmpty})) { recipe in
                        HStack {Spacer()}
                        
                        NavigationLink(
                            destination: RecipeDetailsView(recipe: recipe),
                            label: {
                                //                            Place user in a userCell.
                                RecipeCell(recipe: recipe)
                            }).foregroundColor(.black)
                    }
                }.padding(.leading)
            }
            
           
            
        }
        
    }
}

