//
//  FeedView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 28/02/2021.
//
//  View showing the feed of the user.

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel = FeedViewModel()
    @State var recipes:[Recipe] = []
    @State var done = false
    
    var body: some View {
        
        VStack {
            TitleView(text: "Feed View", iconName: "livephoto")
            Divider()
            ZStack(alignment: .bottomTrailing) {
                // If there are recipes of users following, show them.
                if(viewModel.recipes.count != 0) {
                    ScrollView {
                        VStack {
                            ForEach(viewModel.recipes) { recipe in
                                NavigationLink(
                                    destination: RecipeDetailsView(recipe: recipe),
                                    label: {
                                        //Place user in a userCell.
                                        RecipeCell(recipe: recipe)
                                    }).foregroundColor(.black)
                            }
                            
                        }.padding()
                    }
                }
                // If there are no recipes of followed users, display the appropriate image.
                else {
                    VStack {
                        Spacer()
                        Text("Follow a user to get their recipes on your feed...").font(.system(size: 16)).italic()
                        
                        Image("feed")
                            .resizable()
                            .standardImg()
                        
                        Spacer()
                    }
                }
                // Add a new recipe button.
                HStack{
                    Spacer()
                    AddRecipeButton()
                        .accessibility(identifier: "add_recipe")
                }
            }
            
        }
    }
}
