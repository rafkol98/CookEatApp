//
//  RegistrationView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 09/03/2021.
//

import SwiftUI

struct RegistrationView: View {
    @State var fullname = ""
    @State var username = ""
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        
        ZStack{
           
            VStack {
                
                HStack {
                    Text("Sign Up")
                        .font(.title)
                    Spacer()
                }
                .padding()
                
//                Email and password fields.
                VStack(spacing:16) {
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .background(Color(.init(white: 0.5, alpha: 0.05)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    CustomTextField(text: $fullname, placeholder: Text("Full Name"), imageName: "person")
                        .padding()
                        .background(Color(.init(white: 0.5, alpha: 0.05)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    CustomTextField(text: $username, placeholder: Text("Username"), imageName: "envelope")
                        .padding()
                        .background(Color(.init(white: 0.5, alpha: 0.05)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    CustomSecureField(text: $password, placeholder: Text("Password..."))
                        .padding()
                        .background(Color(.init(white: 0.5, alpha: 0.05)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                
                }
                
//                Sign in button
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(Color.red)
                        .clipShape(Capsule())
                        .padding()
                })

                
                    Spacer()
                
            }
            .padding()
            
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
