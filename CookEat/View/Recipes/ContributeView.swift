//
//  Contribute.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/04/2021.
//

import SwiftUI

struct ContributeView: View {
        
    @State private var addedIngredients = [String]()
    @State private var addedInstructions = [String]()
    let recipe: Recipe
    @ObservedObject var viewModel: RecipeViewModel
    var ingredients: Array<String>
    var instructions: Array<String>
  
    
    @State private var newIngredient = ""
    @State private var newInstruction = ""
    
    init(recipe: Recipe) {
        self.recipe = recipe
        self.viewModel = RecipeViewModel(recipe: recipe)
        self.ingredients = recipe.ingredients
        self.instructions = recipe.instructions
    }
    
    
    var body: some View {
            HStack{
               RecipeTitleView(username: .constant(recipe.username), recipeName: .constant(recipe.recipeName))
                   .padding()
                Spacer()
            }
        
            VStack {
                TextField("Enter an ingredient", text : $newIngredient, onCommit: addNewIngredient)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(addedIngredients + ingredients, id: \.self) {
                    Text($0)
                }
                
                TextField("Enter an instruction", text : $newInstruction, onCommit: addNewInstruction)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(addedInstructions + instructions, id: \.self) {
                    Text($0)
                }
            }
    
    }
    
    //TODO: FIX THIS, its horrible!!!
    //Add a new ingredient.
    func addNewIngredient() {
        let ingredient = newIngredient.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard ingredient.count > 0 else {
            return
        }
        let changed = "+++  \(ingredient)"
        
        addedIngredients.insert(changed, at: 0)
        newIngredient = ""
    }
    
    //Add a new instruction
    func addNewInstruction() {
        let instruction = newInstruction.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        guard instruction.count > 0 else {
            return
        }
        let changed = "+++  \(instruction)"
        
        addedInstructions.insert(changed, at: 0)
        newInstruction = ""
    }
}
