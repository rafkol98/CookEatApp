//
//  RecipeView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 28/02/2021.
//

import SwiftUI

struct RecipeCell: View {
    var body: some View {
        VStack {
            HStack( alignment: .top){
                Image("burger")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 300, height: 300)
                    .cornerRadius(20)
                    .padding()
            }
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCell()
    }
}
