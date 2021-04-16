//
//  EditRecipeView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 16/04/2021.
//

import SwiftUI


struct EditRecipeView: View {
    
    let recipe: Recipe
    
    @State private var ingredients = [String]()
    @State private var instructions = [String]()
    
    @ObservedObject var viewModel: RecipeViewModel
    
    @State private var newIngredient = ""
    @State private var newInstruction = ""
    @State private var addedIngredients = [String]()
    @State private var addedInstructions = [String]()
    @State private var removedIngredients = [String]()
    @State private var removedInstructions = [String]()
    @State private var flag = false
    
    
    init(recipe: Recipe) {
        self.recipe = recipe
        self.viewModel = RecipeViewModel(recipe: recipe)
    }
    
    
    var body: some View {
        
        HStack{
            RecipeTitleView(username: .constant(recipe.username), recipeName: .constant(recipe.recipeName))
            Spacer()
        }.padding()
        
        VStack {

            HeadingView(name: "Ingredients", image: "applescript")
            
            //Add ingredients.
            TextField("Enter an ingredient", text : $newIngredient, onCommit: {
                add(text: &newIngredient, added: &addedIngredients, original: &ingredients)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            
            List {
                ForEach(ingredients, id: \.self) { ingredient in
                    Text(ingredient)
                }
                .onDelete(perform: deleteIngredient)
            }
            
            Divider()
    
            HeadingView(name: "Instructions", image: "list.number")
            
            //Add instructions.
            TextField("Enter an instruction", text : $newInstruction, onCommit: {
                add(text: &newInstruction, added: &addedInstructions, original: &instructions)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            
            List {
                ForEach(instructions, id: \.self) { instruction in
                    Text(instruction)
                }
                .onDelete(perform: deleteInstruction)
            }
            
            
            Button(action: {
                
            }, label: {
                Text("Edit")
                    .standardButton()
            })
          
        }.onAppear {
            // Prefer, Life cycle method
            self.ingredients = recipe.ingredients
            self.instructions = recipe.instructions
        }
        
    }

    //Add ingredient/instruction.
    func add(text: inout String, added: inout Array<String>, original: inout Array<String>) {
        let item = text.trimmingCharacters(in: .whitespacesAndNewlines)

        guard item.count > 0 else {
            return
        }

        added.insert(item, at: 0)
        original.insert(item, at: 0)
        text = ""
    }

    //Delete ingredient.
    func deleteIngredient(at offsets: IndexSet) {
        let index = offsets[offsets.startIndex]

        removedIngredients.insert(ingredients[index], at: 0)
        ingredients.remove(atOffsets: offsets)

    }

    //Delete instruction.
    func deleteInstruction(at offsets: IndexSet) {
        let index = offsets[offsets.startIndex]

        removedInstructions.insert(instructions[index], at: 0)
        instructions.remove(atOffsets: offsets)
    }

}

