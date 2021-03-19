//
//  RecipeDetails.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 17/03/2021.
//

import SwiftUI

struct RecipeDetails: View {
    let heightBox = UIScreen.main.bounds.height / 1.3
    @State private var isExpanded = false
    @State var username = "Bruce"
    @State var recipeName = "burger"
    
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
                //                ScrollView{
                RoundedRectangle(cornerRadius: 40)
                    
                    .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255))
                    
                    .shadow(radius: 10)
                //Users contributed.
                VStack{
                    HStack {
                        ForEach(0..<2) { _ in
                            Image("lady")
                                .resizable()
                                .scaledToFill()
                                .clipped()
                                .frame(width: 40, height: 40)
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
                    //Description.
                    ScrollView{
                        TextEditor(text: .constant("Είπα να μην κολαστώ αλλά δεν μπορώ :) ... Σοφοκλέους έχει καμιά ανακοίνωση για την διαιτησία πόψε; :)"))
                            .frame(width: .infinity, height: 80)
                            .padding(.horizontal)
                            .foregroundColor(Color(red: 40/255, green: 40/255, blue: 40/255))
                            .font(.system(size: 14))
                    }.frame(height:70)
                    
//                    Dropdown box.
                    DisclosureGroup("Ingredients", isExpanded: $isExpanded) {
                        VStack {
                            ScrollView{
                                TextEditor(text: .constant("Είπα να μην κολαστώ αλλά δεν μπορώ :) ... Σοφοκλέους έχει καμιά ανακοίνωση για την διαιτησία πόψε; :)"))
                                    .frame(width: .infinity, height: 80)
                                    .padding(.horizontal)
                                    .foregroundColor(Color(red: 40/255, green: 40/255, blue: 40/255))
                                    .font(.system(size: 14))
                            }.frame(height:150)
                        }
                    }
                    .accentColor(.red)
                    .padding(10)
                    .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.red, lineWidth: 2)
                            )
                    .padding()
                    
                    
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
