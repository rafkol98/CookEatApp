//
//  AddButton.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 21/04/2021.
//

import SwiftUI

struct AddRecipeButton: View {
    
    @State private var showAdd = false
    
    var body: some View {
        
        Button(action: {
            //Toggle flag to open sheet.
            showAdd.toggle()
        }) {
            ZStack {
                Text("")
                    .frame(width: 70, height: 70)
                    .foregroundColor(Color.white)
                    .font(.system(size: 25))
                    .background(Color.red)
                    .clipShape(Circle())

                Image(systemName:"plus.app.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
        }
        //Open add new recipe view as a sheet.
        .sheet(isPresented: $showAdd, content: {
            LazyView(AddRecipeView(showAdd: $showAdd))
        })
        .padding()
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeButton()
    }
}
