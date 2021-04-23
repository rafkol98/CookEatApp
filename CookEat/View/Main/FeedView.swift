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
                ScrollView {
                    VStack {
                        if(viewModel.recipes.count != 0){
                            ForEach(viewModel.recipes) { recipe in
                                NavigationLink(
                                    destination: LazyView(RecipeDetailsView(recipe: recipe)),
                                    label: {
                                        //Place user in a userCell.
                                        RecipeCell(recipe: recipe)
                                    }).foregroundColor(.black)
                            }
                        } else {
                            Spacer()
                            VStack {
                                Text("Follow a user to get their recipes on your feed...").font(.system(size: 16)).italic()
                                
                                Image("feed")
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                    .frame(width: 180, height: 180)
                                
                               
                            }.padding()
                        }
                    }
                    .padding()
                }
                HStack{
                    Spacer()
                    AddRecipeButton()
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
