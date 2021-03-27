//
//  RecipeDetails.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 17/03/2021.
//

import SwiftUI
import Kingfisher

struct RecipeDetails: View {
    let heightBox = UIScreen.main.bounds.height / 1.3
    @State private var isExpanded = false
    @State private var isExpandedInstr = false

    let recipe: Recipe
    
    var body: some View {
        
        VStack {
            KFImage(URL(string: recipe.foodImageUrl))
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(maxWidth: .infinity, maxHeight: 100)
                .padding(.top)
                .shadow(radius: 2)
            
            ZStack {
                //                ScrollView{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255))
                    .shadow(radius: 10)
                
                //Users contributed.
                ScrollView {
                    VStack{
                        
                        HStack {
                            ForEach(0..<1) { _ in
                                KFImage(URL(string: recipe.profileImageUrl))
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
                            RecipeTitleView(username: .constant(recipe.username), recipeName: .constant(recipe.recipeName))
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            Image(systemName: "heart")
                                .font(.system(size:16))
                                .frame(width:32, height:32)
                            Text("0")
                            Spacer()
                        }
                        //Description.
                        ScrollView{
                            TextEditor(text: .constant(recipe.description))
                                .frame(width: .infinity, height: 80)
                                .padding(.horizontal)
                                .foregroundColor(Color(red: 40/255, green: 40/255, blue: 40/255))
                                .font(.system(size: 14))
                        }.frame(height:70)
                        
                        //                    Dropdown box.
                        VStack {
                            DropdownView(title: .constant("Ingredients"), text: .constant(recipe.ingredients), isExpanded: $isExpanded)
                            
                            DropdownView(title: .constant("Instructions"), text: .constant(recipe.instructions), isExpanded: $isExpandedInstr)
                        }
                        Spacer()
                        HStack{
                            Button(action: {
                                
                            }, label: {
                                Text("Fork")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: .infinity, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.red)
                                    .clipShape(Capsule())
                                    .padding()
                                    
                            })
                            
                            Button(action: {
                                
                            }, label: {
                                Text("Contribute")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: .infinity, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.red)
                                    .clipShape(Capsule())
                                    .padding()
                                    
                            })
                            
                        }
                        
                    }
                }
                
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity,
                    alignment: .topLeading)
            
        }
    }
    
}

