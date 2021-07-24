//
//  RecipeDetails.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 17/03/2021.
//
//  Display a recipe in detail.

import SwiftUI
import Kingfisher

struct RecipeDetailsView: View {
    
    let heightBox = UIScreen.main.bounds.height / 1.3
    @State private var isExpanded = false
    @State private var isExpandedInstr = false
    @State private var isLinkActive = false
    @State private var forked = false
   
    
    
    let recipe: Recipe
    @ObservedObject var viewModel: RecipeViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    //Flag determines if the recipe belongs to the current user. It is used to adjust the screen accordingly.
    var flag: Bool {
        let currentUid = authViewModel.user?.id
        return currentUid == recipe.uid ? true : false
    }
    
    init(recipe: Recipe) {
        self.recipe = recipe
        self.viewModel = RecipeViewModel(recipe: recipe)
    }
    
    // Detailed view for recipe, contains all the recipe's information.
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
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255))
                    .shadow(radius: 10)
                
                //Users contributed.
                ScrollView {
                    VStack{
                        
                        HStack {
                            KFImage(URL(string: recipe.profileImageUrl))
                                .resizable()
                                .scaledToFill()
                                .clipped()
                                .frame(width: 40, height: 40)
                                .cornerRadius(50/2)
                                .shadow(radius: 2)
                            
                            Spacer()
                        }
                        .padding(10)
                        
                        HStack {
                            RecipeTitleView(username: .constant(recipe.username), recipeName: .constant(recipe.recipeName))
                                .padding(.horizontal)
                            
                            Spacer()
                            if !flag {
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
                            
                            NavigationLink(
                                destination: VersionControl(recipe: recipe),
                                label: {
                                    Image(systemName: "clock.arrow.2.circlepath")
                                        .font(.system(size:20))
                                        .frame(width:32, height:32)
                                        .foregroundColor(.gray)
                                }).padding()
                            
//                            // Button used to open version control of a recipe.
//                            Button(action: {
//                                // open sheet
//                                versionControl.toggle()
//                            }) {
//                                Image(systemName: "clock.arrow.2.circlepath")
//                                    .font(.system(size:20))
//                                    .frame(width:32, height:32)
//                                    .foregroundColor(.gray)
//                            }
//                            // Open add new recipe view as a sheet.
//                            .sheet(isPresented: $versionControl, content: {
//                                VersionControl(recipe: recipe)
//                            })
//                            .padding()
                            
                            
                        }
                        
                        RecipeDescriptionView(recipe: recipe)
                        
                        IngredientsInstructionsView(ingredients: .constant(recipe.ingredients), instructions: .constant(recipe.instructions))
                        
                        Spacer()
                        
                        HStack{
                            //if the view is not for a user's own recipes then show the fork button.
                            if !flag {
                                Button(action: {
                                    viewModel.forkRecipe()
                                    forked.toggle()
                                }, label: {
                                    HStack {
                                        Image(systemName: "tuningfork")
                                        Text("Fork")
                                    }.adjustButton(with: Color.red)
                                })
                                .alert(isPresented: $forked) {
                                    Alert(title: Text("Forked"), message: Text("The recipe was forked successfully, you can edit it on Account -> View Profile -> Recipe -> Edit"), dismissButton: .default(Text("Awesome")))
                                }
                            }
                            
                            //If the recipe is of the user show the button as edit, otherwise as contribute.
                            Button(action: {
                                self.isLinkActive.toggle()
                            }, label: {
                                HStack {
                                    Image(systemName: flag ? "pencil" : "rectangle.stack.badge.plus")
                                    Text(flag ? "Edit" : "Contribute")
                                } .adjustButton(with: Color.red)
                                
                            })
                            .sheet(isPresented: $isLinkActive, content: {
                                //Open ContributeOrEditView, the editFlag variable determines if the view will be transformed for edit or contribute.
                                ContributeOrEditView(recipe: recipe, editFlag: flag)
                            })
                        }
                        
                        
                    }
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity,
                    alignment: .topLeading)
            
        }
    }
    
}

// Used for displaying the ingredients and instructions in RecipeDetailsView.
struct IngredientsInstructionsView: View {
    @Binding var ingredients: Array<String>
    @Binding var instructions: Array<String>
    
    var body: some View {
        VStack {
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
            }
            .frame(height:200)
        }
        .padding(.horizontal)
        
    }
}
