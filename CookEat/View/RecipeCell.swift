//
//  RecipeView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 01/03/2021.
//

import SwiftUI
import Kingfisher

struct RecipeCell: View {
    
    let recipe: Recipe
    
    var body: some View {
        VStack {
            HStack( alignment: .top) {

                VStack(alignment: .leading) {
                
                    HStack {
                        Image("icon")
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 15, height: 15)
                        
                        Text(recipe.username)
                        Text("/")
                        Text(recipe.recipeName)
                        Spacer()
                            
                    }.font(.system(size: 18, weight: .semibold))
                    
                    Text(recipe.description)
                
                    Text("View Recipe").foregroundColor(.red).padding(.trailing).padding(.top)
                    
                }
                
            }.padding(.top)
            
            Divider()
            
        }
        
    }
}
