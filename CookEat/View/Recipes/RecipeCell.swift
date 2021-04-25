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
    @State var username = ""
    @State var name = ""
    
    var body: some View {
        VStack {
            HStack( alignment: .top) {
                VStack(alignment: .leading) {
                    RecipeTitleView(username: $username, recipeName: $name)
                    
                    Text(recipe.description)
                
                    Text("View Recipe").foregroundColor(.red).padding(.trailing).padding(.top)
                    
                }
                
            }.padding(.top)
            
            Divider()
            
        }.onAppear {
            username = recipe.username
            name = recipe.recipeName
        }
        
    }
}
