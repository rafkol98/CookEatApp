//
//  Contribute.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/04/2021.
//

import SwiftUI

struct ContributeView: View {
    
   
    let recipe: Recipe
    var ingredients: Array<String>
    var instructions: Array<String>
    
    @ObservedObject var viewModel: RecipeViewModel
    
    @State private var newIngredient = ""
    @State private var newInstruction = ""
    @State private var addedIngredients = [String]()
    @State private var addedInstructions = [String]()
    
    
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
            //TODO: fix this
            Heading(name: "Ingredients")
            TextField("Enter an ingredient", text : $newIngredient, onCommit: addNewIngredient)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            List(addedIngredients + ingredients, id: \.self) {
                Text($0)
            }
            
            Divider()
            
            Heading(name: "Instructions")
            TextField("Enter an instruction", text : $newInstruction, onCommit: addNewInstruction)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            List(addedInstructions + instructions, id: \.self) {
                Text($0)
            }
            
            Button(action: {
                viewModel.contributeRecipe(added: addedInstructions)
            }, label: {
                Text("Contribute")
                    .font(.system(size: 22, weight: .semibold))
                    .padding()
                    .frame(width: 300, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
            })
            .background(Color(.systemRed))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding()
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

struct Heading: View {
    @State var name: String
    var body: some View {
        HStack{
            Text(name).font(.title2).bold()
            Spacer()
        }
        .padding()
    }
}
