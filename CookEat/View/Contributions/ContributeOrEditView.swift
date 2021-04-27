//
//  Contribute.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/04/2021.
//

import SwiftUI


struct ContributeOrEditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
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
    @State private var showingAlert = false
    
    
    init(recipe: Recipe, editFlag: Bool) {
        self.recipe = recipe
        self.editFlag = editFlag
        self.viewModel = RecipeViewModel(recipe: recipe)
    }
    
    //Disable button
    var disableButton: Bool {
        if editFlag {
            return addedIngredients.isEmpty && addedInstructions.isEmpty && equalString(stringOne: recipe.recipeName, stringTwo: name) && equalString(stringOne: recipe.description, stringTwo: description)
        } else {
            return addedIngredients.isEmpty && removedIngredients.isEmpty && addedInstructions.isEmpty && removedInstructions.isEmpty
        }
        
    }
    
    //Add red color to the submit button when all the inputs are valid.
    var buttonColor: Color {
        return disableButton ? .accentColor : .red
    }
    
    var body: some View {
        ScrollView {
            
            if editFlag {
                HStack {
                    TitleView(text: "Edit", iconName: "pencil")
                }
                
            } else {
                TitleView(text: "Contribute", iconName: "rectangle.stack.badge.plus")
            }
            
            
            HStack{
                RecipeTitleView(username: .constant(recipe.username), recipeName: .constant(recipe.recipeName))
                Spacer()
                if editFlag {
                    Button(action: {
                        showingAlert.toggle()
                    }, label: {
                        Image(systemName: "trash.fill")
                            .font(.system(size:20))
                            .frame(width:32, height:32)
                            .foregroundColor(.red)
                    })
                    //Ask the user if they want to delete this.
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Are you sure you want to delete this?"),
                            message: Text("This recipe will be permanently deleted."),
                            primaryButton: .destructive(Text("Delete")) {
                                print("Deleting...")
                                viewModel.deleteRecipe()
                                self.presentationMode.wrappedValue.dismiss()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }.padding()
            
            VStack {
                
                // if edit flag, then display the editNameDescriptionView struct, allowing the user to update name and description of the recipe.
                if editFlag {
                    EditNameDescriptionView(recipe: recipe, name: $name, description: $description).padding(.horizontal)
                    
                }
                
                ContributeListView(newIngredient: $newIngredient, ingredients: $ingredients, newInstruction: $newInstruction, instructions: $instructions, addedIngredients: $addedIngredients, addedInstructions: $addedInstructions, removedIngredients: $removedIngredients, removedInstructions: $removedInstructions).padding(.horizontal)
                
                Button(action: {
                    if editFlag {
                        //Edit recipe.
                        viewModel.edit(name: name, description: description, ingredients: ingredients, instructions: instructions)
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        //Contribute to recipe.
                        viewModel.contributeRecipe(addedIngredients: addedIngredients, addedInstructions: addedInstructions, removedIngredients: removedIngredients, removedInstructions: removedInstructions, suggestedIngredients: ingredients, suggestedInstructions: instructions)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                }, label: {
                    Text(editFlag ? "Update" : "Contribute")
                        .adjustButton(with: buttonColor)
                })
                .disabled(disableButton)
            }
        }.onAppear {
            self.name = recipe.recipeName
            self.description = recipe.description
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

