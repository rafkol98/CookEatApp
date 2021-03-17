//
//  RecipeDetails.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 17/03/2021.
//

import SwiftUI

struct RecipeDetails: View {
    let heightBox = UIScreen.main.bounds.height / 1.3
    @State var username = "Bruce"
    @State var recipeName = "pizza"
    
    var body: some View {
        
        VStack {
            Image("burger")
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(maxWidth: .infinity, maxHeight: 100)
                .padding(.top)
                .shadow(radius: 2)
            
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    
                    .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255))
                    
                    .shadow(radius: 10)
                
                VStack{
                    HStack {
                        ForEach(0..<2) { _ in
                            Image("lady")
                                .resizable()
                                .scaledToFill()
                                .clipped()
                                .frame(width: 50, height: 50)
                                .cornerRadius(50/2)
                                .shadow(radius: 2)
                        }
                        Spacer()
                    }
                    .padding(10)
                    
                    HStack {
                        RecipeTitleView(username: $username, recipeName: $recipeName)
                            .padding(.horizontal)
                        
                        Spacer()
                    }
                    TextEditor(text: .constant("Είπα να μην κολαστώ αλλά δεν μπορώ :) ... Σοφοκλέους έχει καμιά ανακοίνωση για την διαιτησία πόψε; :)"))
                        .frame(width: .infinity, height: 80)
                        .padding(.horizontal)
                        .foregroundColor(Color(red: 40/255, green: 40/255, blue: 40/255))
                    
                    Spacer()
                    
                }
            }.frame(maxWidth: .infinity, maxHeight: heightBox,
                    alignment: .topLeading)
            
        }
    }
    
}



struct RecipeDetails_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetails()
    }
}
