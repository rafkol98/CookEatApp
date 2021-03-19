//
//  RecipeView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 01/03/2021.
//

import SwiftUI

struct RecipeCell: View {
    @State var username = "Marios"
    @State var recipeName = "Pizza Mia"
    
    var body: some View {
        VStack {
            HStack( alignment: .top) {

                VStack(alignment: .leading) {
//                    HStack {
//                        Image("icon")
//                            .resizable()
//                            .scaledToFill()
//                            .clipped()
//                            .frame(width: 15, height: 15)
//
//                        Text("Bruce Mario")
//                        Text("/ pizza-mia")
//
//                    }
//                    .font(.system(size: 18, weight: .semibold))
                    RecipeTitleView(username: $username, recipeName: $recipeName)
                    
                    Text("It's not what I am that defines me, but what I cook!")
                
                    Text("View Recipe").foregroundColor(.red).padding(.trailing).padding(.top)
                    
                }
                
            }.padding(.top)
            
            Divider()
            
        }
        
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCell()
    }
}

