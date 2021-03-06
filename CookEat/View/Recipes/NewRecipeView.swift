//
//  NewRecipeView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/03/2021.
//

import SwiftUI

struct NewRecipeView: View {
    @Binding var isPresented : Bool
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image("lady")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 64, height: 64)
                        .cornerRadius(32)
                    
                    Text("Type something...")
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                .padding()
//  On cancel, toggle isPresented variable -> this will close the screen.
                .navigationBarItems(leading: Button(action: { isPresented.toggle() }, label: {
                    Text("Cancel")
                        .foregroundColor(.red)
                }), trailing: Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Add")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
            }))
                Spacer()
            }
        }
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView(isPresented: .constant(true))
    }
}

