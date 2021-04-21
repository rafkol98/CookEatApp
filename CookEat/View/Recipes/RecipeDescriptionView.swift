//
//  RecipeDescriptionView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 08/04/2021.
//

import SwiftUI

// Shows the description of a recipe in a formatted textEditor.
struct RecipeDescriptionView: View {
    
    let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        //Description.
        ScrollView{
            TextEditor(text: .constant(recipe.description))
                .frame(width: .infinity, height: 80)
                .padding(.horizontal)
                .foregroundColor(Color(red: 40/255, green: 40/255, blue: 40/255))
                .font(.system(size: 17))
        }
        .frame(height:70)
    }
}
