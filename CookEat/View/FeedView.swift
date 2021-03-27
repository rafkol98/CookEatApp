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
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack {
                    ForEach(viewModel.recipes) { recipe in
//                        NavigationLink
                        NavigationLink(
                            destination: RecipeDetails(recipe: recipe),
                            label: {
    //                            Place user in a userCell.
                                RecipeCell(recipe: recipe)
                            }).foregroundColor(.black)
                        

                    }
                }.padding()
            }
            
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
