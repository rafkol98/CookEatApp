//
//  LoginView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 09/03/2021.
//
//  Login view.

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State private var error = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 100)
                        .padding(.top)
                        .padding(.bottom, 32)
                    
                    //  Email and password fields.
                    VStack(spacing:16) {
                        CustomTextField(text: $email, placeholder: Text("Email..."), imageName: "envelope")
                            .inputModifier()
                            .accessibilityLabel("email")
                            
                        
                        CustomSecureField(text: $password, placeholder: Text("Password..."))
                            .inputModifier()
                            
                        
                    }
                    
                    // Sign in button
                    Button(action: {
                        viewModel.login(withEmail: email, password: password)
//                        if viewModel.userSession == nil {
//                            error.toggle()
//                        }
                    }, label: {
                        Text("Sign In")
                            .standardButton()
                    })
//                    .alert(isPresented: $error, content: {
//                        Alert(title: Text("Verify your Email ID"), message: Text("Please click the link in the verification email sent to you"), dismissButton: .default(Text("Dismiss")))
//                    })
                    
                    // Push everything to the top.
                    Spacer()
                    
                    NavigationLink(
                        destination: RegistrationView(),
                        label: {
                            Text("Sign Up")
                                .font(.system(size: 20, weight: .semibold))
                                .padding()
                        })
                        .foregroundColor(.black)
                    
                }
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
