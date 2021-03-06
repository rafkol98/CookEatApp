//
//  EditNameDescription.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 16/04/2021.
//
//  Struct used to edit the name and description of a recipe.

import SwiftUI

struct EditNameDescriptionView: View {
    let recipe: Recipe
    @Binding var name: String
    @Binding var description: String
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            // Small input for a new recipe name.
            SmallInput(name: "New Recipe Name", existingText: recipe.recipeName, iconName: "textformat", stringIn: $name, valid: !equalString(stringOne: recipe.recipeName, stringTwo: name))
            
            // Large input for a new description.
            LargeInput(name: "New Description",  iconName: "bubble.right", stringIn: $description, valid: !equalString(stringOne: recipe.description, stringTwo: description))
        }
    }
}
