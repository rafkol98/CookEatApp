//
//  RecipeDetails.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 17/03/2021.
//

import SwiftUI
import Kingfisher

struct RecipeDetailsView: View {
    
    let heightBox = UIScreen.main.bounds.height / 1.3
    @State private var isExpanded = false
    @State private var isExpandedInstr = false
    @State var isLinkActive = false
    
    let recipe: Recipe
    @ObservedObject var viewModel: RecipeViewModel
    
    init(recipe: Recipe) {
        self.recipe = recipe
        self.viewModel = RecipeViewModel(recipe: recipe)
    }
    
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
                            Button(action: {
                                viewModel.didLike ? viewModel.unlikeRecipe() :viewModel.likeRecipe()
                            }, label: {
                                Image(systemName: viewModel.didLike ? "heart.fill" : "heart")
                                    .font(.system(size:20))
                                    .frame(width:32, height:32)
                                    .foregroundColor(viewModel.didLike ? .red : .gray)
                            }
                            ).padding()
                        }
                        
                        RecipeDescriptionView(recipe: recipe)
 
                        IngredientsInstructionsView(ingredients: .constant(recipe.ingredients), instructions: .constant(recipe.instructions))
                        Spacer()
                        HStack{
                            Button(action: {
                                viewModel.forkRecipe()
                            }, label: {
                                Text("Fork")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: .infinity, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.red)
                                    .clipShape(Capsule())
                                    .padding()
                                
                            })
                            
                            NavigationLink(
                                destination: LazyView(ContributeView(recipe: recipe)),  isActive: $isLinkActive,
                                label: {
                                    Button(action: {
                                        self.isLinkActive = true
                                    }, label: {
                                        Text("Contribute")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: .infinity, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .background(Color.red)
                                            .clipShape(Capsule())
                                            .padding()
                                        
                                    })
                                })
                         
                            
                        }
                        
                    }
                }
                
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity,
                    alignment: .topLeading)
            
        }
    }
    
}


struct IngredientsInstructionsView: View {
    @Binding var ingredients: Array<String>
    @Binding var instructions: Array<String>
    
    var body: some View {
        
        HeadingView(name: "Ingredients", image: "applescript")
        List {
            ForEach(ingredients, id: \.self) { ingredient in
                Text(ingredient)
            }
        }.frame(height:200)
        
        HeadingView(name: "Instruction", image: "list.number")
        List {
            ForEach(instructions, id: \.self) { instruction in
                Text(instruction)
            }
        }.frame(height:200)
        
    }
}
