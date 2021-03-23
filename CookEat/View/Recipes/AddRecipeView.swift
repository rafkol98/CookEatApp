//
//  AddRecipeView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 24/03/2021.
//

import SwiftUI

struct AddRecipeView: View {
    @State var name: String = ""
    @State var address: String = ""
    @State var email: String = ""
    var body: some View {
        VStack{
            TextField("Recipe Name", text: $name)
            TextEditor(text: $email)
        }
     
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
