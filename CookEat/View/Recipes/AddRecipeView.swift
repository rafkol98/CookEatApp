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
    @State var ingredients: String = ""
    @State var instructions: String = ""
    @State var addImage = false
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    
    @ObservedObject var viewModel = UploadRecipeViewModel()
    
    //convert a ui image into a SwiftUI image. REPETITIVE -> FIX THIS LATER.
    func loadImage() {
        guard let selectedImage = selectedUIImage else {return}
        image = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        VStack{
            HStack(alignment: .top ){
//                if let user = AuthViewModel.shared.user{
//                    KFImage(URL(string: user.profileImageUrl))
//                        .resizable()
//                        .scaledToFill()
//                        .clipped()
//                        .frame(width: 64, height: 64)
//                        .cornerRadius(32)
//                }
//
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
                                //                    Rendering mode allows us to add a colour to the image.
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
            SmallInput(name: "RecipeName", stringIn: $name)
            LargeInput(name: "Description", stringIn: $description)
            LargeInput(name: "Ingredients", stringIn: $ingredients)
            LargeInput(name: "Instructions", stringIn: $instructions)
            
            Button(action: {
                guard let image = selectedUIImage else { return }
                viewModel.upload(name: name, description: description, ingredients: ingredients, instructions: instructions, image: image)
            }, label: {
                Text("Add Recipe")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 360, height: 50)
                    .background(Color.red)
                    .clipShape(Capsule())
                    .padding()
            })
            
        }.padding()
        .foregroundColor(.black)
        
    }
}

struct SmallInput: View {
    let name: String
    @Binding
    var stringIn: String
    
    var body: some View {
        HStack{
            Text(name)
            Spacer()
        }
        TextField("", text: $stringIn)
            .foregroundColor(Color.black)
            .font(.custom("HelveticaNeue", size: 14))
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
            )
    }
}


struct LargeInput: View {
    let name: String
    @Binding
    var stringIn: String
    
    var body: some View {
        HStack{
            Text(name)
            Spacer()
        }
        
        TextEditor(text:  $stringIn)
            .foregroundColor(Color.black)
            .font(.custom("HelveticaNeue", size: 14))
            .lineSpacing(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
            )
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
