//
//  RecipeTitleView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 17/03/2021.
//
//  Used to show a title of the recipe.

import SwiftUI

struct RecipeTitleView: View {
    @Binding var username: String
    @Binding var recipeName: String
    
    var body: some View {
        // Title for recipe.
        HStack {
            Image("icon")
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 15, height: 15)
            
            Text(username)
            Text("/")
            Text(recipeName)
            Spacer()
                
        }.font(.system(size: 18, weight: .semibold))
    }
}
