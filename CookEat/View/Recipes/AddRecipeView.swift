//
//  AddRecipeView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 25/03/2021.
//

import SwiftUI
import Kingfisher

struct AddRecipeView: View {
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
        return invalid(varIn: name) ||  invalid(varIn: description) ||  invalidArray(varIn: ingredients) ||  invalidArray(varIn: instructions) || selectedUIImage==nil
    }
    
    var validName: Color {
        //Check if input is valid.
        return (name.count <= 50) ? .green : .accentColor
    }
    
    func validBox(varIn: String) -> Color {
        //Check if input is valid.
        return (varIn.count <= 1000) ? .green : .accentColor
    }
    
    //Invalid input
    func invalid(varIn: String) -> Bool {
        return varIn.isEmpty || varIn.count > 1000
    }
    
    func invalidArray(varIn: Array<String>) -> Bool {
        return varIn.isEmpty
    }
    
    //Add red color to the button when all the inputs are valid.
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
                
                if added {
                    Text("The recipe was added!")
                        .font(.system(size:20))
                        .foregroundColor(Color.black)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color.green, lineWidth: 2)
                        )
                }
                
                HStack(alignment: .top ){
                    Button(action: { addImage.toggle() }, label: {
                        ZStack {
                            if let image = image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(60)
                                    .padding()
                                
                            } else {
                                Image("add_photo")
                                    .resizable()
                                    //Rendering mode allows us to add a colour to the image.
                                    .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .padding()
                                    .foregroundColor(.red)
                            }
                            
                        }
                        
                    }).sheet(isPresented: $addImage, onDismiss: loadImage, content: {
                        ImagePicker(image: $selectedUIImage)
                    })
                }
                
                SmallInput(name: "RecipeName", existingText: "", iconName: "textformat", stringIn: $name, valid: validName)
                LargeInput(name: "Description",  iconName: "bubble.right", stringIn: $description, valid: validBox(varIn: description))
                ListView2(newIngredient: $newIngredient, ingredients: $ingredients, newInstruction: $newInstruction, instructions: $instructions)
                
                Button(action: {
                    guard let image = selectedUIImage else { return }
                    viewModel.upload(name: name, description: description, ingredients: ingredients, instructions: instructions, image: image)
                    added.toggle()
                    name = ""
                    description = ""
                    ingredients = []
                    instructions = []
                    selectedUIImage = nil
                }, label: {
                    Text("Add Recipe")
                        .adjustButton(with: buttonColor)
                    
                }).disabled(disableButton)
                
                
            }.padding()
            .foregroundColor(.black)
            
        }
        
    }
    
    
}
