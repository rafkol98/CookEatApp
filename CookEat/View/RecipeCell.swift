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
            HStack( alignment: .top) {
                Image("burger")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 150, height: 150)
                    .cornerRadius(20)
                    
                
                VStack(alignment: .leading) {
                    Text("Bruce Wayne")
                        .font(.system(size: 14, weight: .semibold))
                    HStack{
                        Text("@Batman")
                            .foregroundColor(.gray)
                        
                        Text("2w")
                            .foregroundColor(.gray)
                    }
                    
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
