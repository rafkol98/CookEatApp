//
//  Contribute.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/04/2021.
//

import SwiftUI


struct ContributeView: View {
    
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
    
    //    @State private var x = viewModel.fetchIngredients()
    
    var body: some View {
        
        HStack{
            RecipeTitleView(username: .constant(recipe.username), recipeName: .constant(recipe.recipeName))
            Spacer()
        }.padding()
        
        VStack {
            //TODO: fix this - maybe do a new view which takes arguments.
            HeadingView(name: "Ingredients", image: "applescript")
            
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
                viewModel.contributeRecipe(addedIngredients: addedIngredients, addedInstructions: addedInstructions, removedIngredients: removedIngredients, removedInstructions: removedInstructions)
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
