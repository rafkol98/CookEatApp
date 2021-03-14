//
//  RecipeDetailedView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 14/03/2021.
//

import SwiftUI

struct RecipeDetailedView: View {
    let heightBox = UIScreen.main.bounds.height / 1.4

    var body: some View {
        
        VStack {
            Image("burger")
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(maxWidth: .infinity, maxHeight: 120)
//                .cornerRadius(120/2)
                .padding(.top)
            
            RoundedRectangle(cornerRadius: 40)
                .padding(.top)
                .foregroundColor(Color(red: 222/255, green: 222/255, blue: 222/255))
                .frame(maxWidth: .infinity, maxHeight: heightBox,
                       alignment: .topLeading)
                .shadow(radius: 10)
        }
    }
}

struct RecipeDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailedView()
    }
}
