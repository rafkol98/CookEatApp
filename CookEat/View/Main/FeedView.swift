//
//  FeedView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 28/02/2021.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                // If there are recipes of users following, show them.
                if(viewModel.recipes.count != 0) {
                    ScrollView {
                        VStack {
                            ForEach(viewModel.recipes) { recipe in
                                NavigationLink(
                                    destination: LazyView(RecipeDetailsView(recipe: recipe)),
                                    label: {
                                        //Place user in a userCell.
                                        RecipeCell(recipe: recipe)
                                    }).foregroundColor(.black)
                            }
                        }.padding()
                    }
                }
                // If there are not recipes display an image.
                else {
                    VStack {
                        Spacer()
                        Text("Follow a user to get their recipes on your feed...").font(.system(size: 16)).italic()
                        
                        Image("feed")
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 180, height: 180)
                        
                        Spacer()
                    }
                }
                
            }
            HStack{
                Spacer()
                AddRecipeButton()
            }
        }
    }
}


struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
