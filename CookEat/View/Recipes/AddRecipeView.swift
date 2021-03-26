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
    
    @ObservedObject var viewModel = UploadRecipeViewModel()
    
    var body: some View {
        VStack{
            HStack(alignment: .top ){
                if let user = AuthViewModel.shared.user{
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 64, height: 64)
                        .cornerRadius(32)
                }
                VStack(alignment: .center) {
                    Text("Add Recipe")
                        .font(.system(size: 28))
                }
                
                Spacer()
            }
            SmallInput(name: "RecipeName", stringIn: $name)
            LargeInput(name: "Description", stringIn: $description)
            LargeInput(name: "Ingredients", stringIn: $ingredients)
            LargeInput(name: "Instructions", stringIn: $instructions)
            
            Button(action: {
                viewModel.upload(name: name, description: description, ingredients: ingredients, instructions: instructions)
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
            .foregroundColor(Color.gray)
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
            .foregroundColor(Color.gray)
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
