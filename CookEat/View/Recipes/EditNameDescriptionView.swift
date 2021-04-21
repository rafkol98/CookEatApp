//
//  EditNameDescription.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 16/04/2021.
//

import SwiftUI

struct EditNameDescriptionView: View {
    let recipe: Recipe
    @Binding var name: String
    @Binding var description: String
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            SmallInput(name: "New Recipe Name", existingText: recipe.recipeName, iconName: "textformat", stringIn: $name, valid: !equalString(stringOne: recipe.recipeName, stringTwo: name))
            
            LargeInput(name: "New Description",  iconName: "bubble.right", stringIn: $description, valid: !equalString(stringOne: recipe.description, stringTwo: description))
        }
    }
}
