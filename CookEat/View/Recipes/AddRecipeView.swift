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
                
                SmallInput(name: "RecipeName", iconName: "textformat", stringIn: $name, valid: validName)
                LargeInput(name: "Description",  iconName: "bubble.right", stringIn: $description, valid: validBox(varIn: description))
                ListView(newIngredient: $newIngredient, ingredients: $ingredients, newInstruction: $newInstruction, instructions: $instructions)
                
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
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(buttonColor)
                        .clipShape(Capsule())
                        .padding()
                }).disabled(disableButton)
                
                
            }.padding()
            .foregroundColor(.black)
            
        }
        
    }
    
    
}


//Small input text.
struct SmallInput: View {
    let name: String
    let iconName: String
    @Binding
    var stringIn: String
    var valid: Color
    
    var body: some View {
        HeadingView(name: name, image: iconName)
        TextField("", text: $stringIn)
            .foregroundColor(Color.black)
            .font(.custom("HelveticaNeue", size: 14))
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(stringIn.isEmpty ? Color(.systemGray3) : valid, lineWidth: 2)
            )
    }
}

//Large input text.
struct LargeInput: View {
    let name: String
    let iconName: String
    @Binding
    var stringIn: String
    var valid: Color
    
    var body: some View {
        HeadingView(name: name, image: iconName)
        TextEditor(text:  $stringIn)
            .foregroundColor(Color.black)
            .font(.custom("HelveticaNeue", size: 14))
            .padding()
            .lineSpacing(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(stringIn.isEmpty ? Color(.systemGray3) : valid, lineWidth: 2)
            )
            .frame(height: 100)
        
    }
}


// Ingredients and Instructions list.
struct ListView: View {
    @Binding var newIngredient: String
    @Binding var ingredients: Array<String>
    @Binding var newInstruction: String
    @Binding var instructions: Array<String>
    
    
    var body: some View {
        
        HeadingView(name: "Ingredients", image: "applescript")
        VStack {
            TextField("Enter an ingredient", text : $newIngredient, onCommit: {
                add(text: &newIngredient, list: &ingredients)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            List {
                ForEach(ingredients, id: \.self) { ingredient in
                    Text(ingredient)
                }
                .onDelete(perform: deleteIngredient)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(ingredients.isEmpty ? Color(.systemGray3) : Color.green, lineWidth: 2)
        )
        .frame(height:200)
        
        HeadingView(name: "Instruction", image: "list.number")
        VStack{
            TextField("Enter an instruction", text : $newInstruction, onCommit: {
                add(text: &newInstruction, list: &instructions)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            //            .padding(.horizontal)
            
            List {
                ForEach(instructions, id: \.self) { instruction in
                    Text(instruction)
                }
                .onDelete(perform: deleteInstruction)
            }
        }.overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(instructions.isEmpty ? Color(.systemGray3) : Color.green, lineWidth: 2)
        )
        .frame(height:200)
    }
    
    //Add ingredient/instruction.
    func add(text: inout String, list: inout Array<String>) {
        let item = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard item.count > 0 else {
            return
        }
        
        list.insert(item, at: 0)
        text = ""
    }
    
    //Delete ingredient.
    func deleteIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
    
    //Delete ingredient.
    func deleteInstruction(at offsets: IndexSet) {
        instructions.remove(atOffsets: offsets)
    }
}
