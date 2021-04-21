//
//  ListView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 16/04/2021.
//

import SwiftUI

// Ingredients and Instructions list.
struct ContributeListView: View {
    @Binding var newIngredient: String
    @Binding var ingredients: Array<String>
    @Binding var newInstruction: String
    @Binding var instructions: Array<String>
    @Binding var addedIngredients:  Array<String>
    @Binding var addedInstructions:  Array<String>
    @Binding var removedIngredients:  Array<String>
    @Binding var removedInstructions:  Array<String>
    
    
    var body: some View {
        
        HeadingView(name: "Ingredients", image: "applescript")
        VStack {
            TextField("Enter an ingredient", text : $newIngredient, onCommit: {
                add(text: &newIngredient, added: &addedIngredients, original: &ingredients)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            List {
                ForEach(ingredients, id: \.self) { ingredient in
                    Text(ingredient)
                }
                .onDelete(perform: deleteIngredient)
                .onMove(perform: moveIngredient)
            }
            .environment(\.editMode, Binding.constant(EditMode.active))
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(ingredients.isEmpty ? Color(.systemGray3) : Color.green, lineWidth: 2)
        )
        .frame(height:200)
        
        HeadingView(name: "Instruction", image: "list.number")
        VStack{
            TextField("Enter an instruction", text : $newInstruction, onCommit: {
                add(text: &newInstruction, added: &addedInstructions, original: &instructions)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            List {
                ForEach(instructions, id: \.self) { instruction in
                    Text(instruction)
                }
                .onDelete(perform: deleteInstruction)
                .onMove(perform: moveInstruction)
                
            }
            .environment(\.editMode, Binding.constant(EditMode.active))
            
        }.overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(instructions.isEmpty ? Color(.systemGray3) : Color.green, lineWidth: 2)
        )
        .frame(height:200)
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
    
    func moveInstruction(from source: IndexSet, to destination: Int) {
        instructions.move(fromOffsets: source, toOffset: destination)
    }
    
    func moveIngredient(from source: IndexSet, to destination: Int) {
        ingredients.move(fromOffsets: source, toOffset: destination)
    }
}
