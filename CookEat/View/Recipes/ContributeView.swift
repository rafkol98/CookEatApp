//
//  Contribute.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/04/2021.
//

import SwiftUI

struct ContributeView: View {
    
    @State var ingredients: String = ""
    @State var instructions: String = ""
    
    let recipe: Recipe
    @ObservedObject var viewModel: RecipeViewModel
    
    init(recipe: Recipe) {
        self.recipe = recipe
        self.viewModel = RecipeViewModel(recipe: recipe)
    }
    
    var body: some View {
        VStack{
            HStack {
                Text("Contribute")
                    .font(.title)
                Spacer()
            }.padding()
            
            HStack{
                RecipeTitleView(username: .constant(recipe.username), recipeName: .constant(recipe.recipeName))
                    .padding(.horizontal)
                
                Spacer()
            }
            
            
            TextEditor(text: .constant(recipe.description))
                .frame(width: .infinity, height: 80)
                .padding(.horizontal)
                .foregroundColor(Color(red: 40/255, green: 40/255, blue: 40/255))
                .font(.system(size: 17))
            
            LargeInput(name: "Ingredients", stringIn: $ingredients, valid: Color.green).padding()
            LargeInput(name: "Instructions", stringIn: $instructions, valid: Color.green).padding()
            
            Spacer()
        }
        
        
        
    }
}
