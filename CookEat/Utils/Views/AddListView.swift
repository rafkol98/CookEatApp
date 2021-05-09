//
//  ListView2.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 17/04/2021.
//
//  Add ingredients/instructions view.

import SwiftUI


struct AddListView: View {
    @Binding var newIngredient: String
    @Binding var ingredients: Array<String>
    @Binding var newInstruction: String
    @Binding var instructions: Array<String>
    
    
    var body: some View {
        
        HeadingView(name: "Ingredients", image: "applescript")
        VStack {
            TextField("Enter an ingredient", text : $newIngredient, onCommit: {
                add(text: &newIngredient, list: &ingredients)
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
        if (invalidArray(varIn: ingredients)) {
            InvalidView(stringIn: "Ensure that you added at least one ingredient.")
        }
        
        HeadingView(name: "Instruction", image: "list.number")
        VStack{
            TextField("Enter an instruction", text : $newInstruction, onCommit: {
                add(text: &newInstruction, list: &instructions)
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
        if (invalidArray(varIn: instructions)) {
            InvalidView(stringIn: "Ensure that you added at least one instruction.")
        }
    }
    
    //Add ingredient/instruction.
    func add(text: inout String, list: inout Array<String>) {
        let item = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard item.count > 0 else {
            return
        }
        
        list.insert(item, at: 0)
        text = ""
    }
    
    // Delete ingredient.
    func deleteIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
    
    // Delete ingredient.
    func deleteInstruction(at offsets: IndexSet) {
        instructions.remove(atOffsets: offsets)
    }
    
    // Move instruction.
    func moveInstruction(from source: IndexSet, to destination: Int) {
         instructions.move(fromOffsets: source, toOffset: destination)
     }
    
    // Move ingredient.
    func moveIngredient(from source: IndexSet, to destination: Int) {
         ingredients.move(fromOffsets: source, toOffset: destination)
     }
}
