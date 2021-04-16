//
//  Contribute.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/04/2021.
//

import SwiftUI


struct ContributeOrEditView: View {
    
    let recipe: Recipe
    let editFlag : Bool
    
    @State private var ingredients = [String]()
    @State private var instructions = [String]()
    
    @ObservedObject var viewModel: RecipeViewModel
    
    @State var name = ""
    @State var description = ""
    @State private var newIngredient = ""
    @State private var newInstruction = ""
    @State private var addedIngredients = [String]()
    @State private var addedInstructions = [String]()
    @State private var removedIngredients = [String]()
    @State private var removedInstructions = [String]()
//    @State private var flag = false
    
    
    init(recipe: Recipe, editFlag: Bool) {
        self.recipe = recipe
        self.editFlag = editFlag
        self.viewModel = RecipeViewModel(recipe: recipe)
    }
    
    var body: some View {
        ScrollView {
            
        if editFlag {
            TitleView(text: "Edit", iconName: "pencil")
        } else {
            TitleView(text: "Contribute", iconName: "rectangle.stack.badge.plus")
        }
        
        
        HStack{
            RecipeTitleView(username: .constant(recipe.username), recipeName: .constant(recipe.recipeName))
            Spacer()
        }.padding()
        
        VStack {
            
            if editFlag {
                EditNameDescriptionView(name: $name, description: $description).padding(.horizontal)
            }
            
            ListView(newIngredient: $newIngredient, ingredients: $ingredients, newInstruction: $newInstruction, instructions: $instructions).padding(.horizontal)

          
            Button(action: {
                if editFlag {
                    viewModel.edit(name: name, description: description, ingredients: ingredients, instructions: instructions)
                } else {
                    viewModel.contributeRecipe(addedIngredients: addedIngredients, addedInstructions: addedInstructions, removedIngredients: removedIngredients, removedInstructions: removedInstructions, suggestedIngredients: ingredients, suggestedInstructions: instructions)
                }
                
            }, label: {
                Text(editFlag ? "Edit" : "Contribute")
                    .standardButton()
            })
        }
        }.onAppear {
            self.name = recipe.recipeName
            self.description = recipe.description
            self.ingredients = recipe.ingredients
            self.instructions = recipe.instructions
        }
        
    }
    
}

