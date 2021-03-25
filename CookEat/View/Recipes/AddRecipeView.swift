//
//  AddRecipeView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 24/03/2021.
//

import SwiftUI

struct AddRecipeView: View {
    @State var name: String = ""
    @State var ingredients: String = ""
    @State var instructions: String = ""
    @State var description: String = ""
    
    var body: some View {
        VStack{
            SmallInput(name: "RecipeName", stringIn: $name)
            LargeInput(name: "Description", stringIn: $description)
            LargeInput(name: "Ingredients", stringIn: $ingredients)
            LargeInput(name: "Instructions", stringIn: $instructions)
            
            Button(action: {
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
