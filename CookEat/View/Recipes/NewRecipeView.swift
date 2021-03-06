//
//  NewRecipeView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/03/2021.
//

import SwiftUI

struct NewRecipeView: View {
    @Binding var isPresented : Bool
    @State var username: String = ""

    var body: some View {
        NavigationView {
           
            VStack {

                Text("Instructions")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)

                VStack(alignment: .leading) {
                
                   
                    TextEditor(text: $username)
                                .foregroundColor(Color.gray)
                                .font(.custom("HelveticaNeue", size: 13))
                                .lineSpacing(5)
                                
                }
                .overlay(
                         RoundedRectangle(cornerRadius: 25)
                           .stroke(Color.gray, lineWidth: 2)
                         )
                .padding()
                
                Text("Ingredients")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    
                
                VStack(alignment: .leading) {
                    
                    TextEditor(text: $username)
                                .foregroundColor(Color.gray)
                                .font(.custom("HelveticaNeue", size: 13))
                                .lineSpacing(5)
                                
                }
                .overlay(
                         RoundedRectangle(cornerRadius: 25)
                           .stroke(Color.gray, lineWidth: 2)
                         )
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

