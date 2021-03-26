//
//  RecipeTitleView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 17/03/2021.
//

import SwiftUI

struct RecipeTitleView: View {
    @State var username: String
    @State var recipeName: String
    
    var body: some View {
        HStack {
            Image("icon")
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 15, height: 15)
            
            Text(username)
            Text("/")
            Text(recipeName)
                
        }.font(.system(size: 18, weight: .semibold))
    }
}

struct RecipeTitleView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTitleView(username: .constant("Username"), recipeName:.constant("Recipe"))
    }
}
