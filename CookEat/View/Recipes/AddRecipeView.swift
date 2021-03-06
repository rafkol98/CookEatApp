//
//  AddRecipeView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 25/03/2021.
//
//  View used to add a new recipe.

import SwiftUI
import Kingfisher

struct AddRecipeView: View {
    
    @Binding var showAdd : Bool
    
    @State var name: String = ""
    @State var description: String = ""
    
    @State var addImage = false
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    @State var added = false
    
    @State private var newIngredient = ""
    @State private var ingredients = [String]()
    
    @State private var newInstruction = ""
    @State private var instructions = [String]()
    
    
    @ObservedObject var viewModel = UploadRecipeViewModel()
    
    
    //Disable button
    var disableButton: Bool {
        return invalid(varIn: name, minBoundary: 5, maxBoundary: 50) ||  invalid(varIn: description, minBoundary: 10, maxBoundary: 1000) ||  invalidArray(varIn: ingredients) ||  invalidArray(varIn: instructions) || selectedUIImage==nil
    }
    
    //Add red color to the submit button when all the inputs are valid.
    var buttonColor: Color {
        return disableButton ? .accentColor : .red
    }
    
    //convert a ui image into a SwiftUI image. REPETITIVE -> FIX THIS LATER.
    func loadImage() {
        guard let selectedImage = selectedUIImage else {return}
        image = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        ScrollView{
            VStack{
                TitleView(text: "Add Recipe", iconName: "plus.app")

                HStack(alignment: .top ){
                    Button(action: { addImage.toggle() }, label: {
                        ZStack {
                            if let image = image {
                                image
                                    .resizable()
                                    .circularImg()
                                
                            } else {
                                Image("add_photo")
                                    .resizable()
                                    .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.red)
                                    .circularImg()
                                    
                            }
                            
                        }
                        
                    }).sheet(isPresented: $addImage, onDismiss: loadImage, content: {
                        ImagePicker(image: $selectedUIImage)
                    })
                }
                if (selectedUIImage==nil) {
                    InvalidView(stringIn: "Please upload a picture for your recipe")
                }
                
                SmallInput(name: "Recipe Name", existingText: "", iconName: "textformat", stringIn: $name, valid: !invalid(varIn: name, minBoundary: 5, maxBoundary: 50))
                //Show message if invalid.
                if (invalid(varIn: name, minBoundary: 5, maxBoundary:50)) {
                    InvalidView(stringIn: "Ensure that recipe name is between 5 to 50 characters")
                }
                
                LargeInput(name: "Description",  iconName: "bubble.right", stringIn: $description, valid: !invalid(varIn: description, minBoundary: 10, maxBoundary: 1000))
                //Show message if invalid.
                if (invalid(varIn: description, minBoundary: 10, maxBoundary: 1000)) {
                    InvalidView(stringIn: "Ensure the description is between 10 to 1000 characters")
                }
                
                //List views used for ingredients and instructions.
                AddListView(newIngredient: $newIngredient, ingredients: $ingredients, newInstruction: $newInstruction, instructions: $instructions)
                
                Button(action: {
                    guard let image = selectedUIImage else { return }
                    viewModel.upload(name: name, description: description, ingredients: ingredients, instructions: instructions, image: image)
                    added.toggle()
                    
                }, label: {
                    Text("Add Recipe")
                        .adjustButton(with: buttonColor)
                    
                })
                //If message was added, alert user.
                .alert(isPresented: $added) {
                    Alert(title: Text("Recipe Added"),
                        message: Text("Your recipe was added succesfully!"),
                        dismissButton: Alert.Button.default(
                            Text("Awesome"), action: { showAdd.toggle() }
                        )
                    )
                }
                .disabled(disableButton)
                
                
            }.padding()
            .foregroundColor(.black)
            
        }
        
    }
    
    
}
