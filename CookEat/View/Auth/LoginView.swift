//
//  LoginView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 09/03/2021.
//
//  Login view.

import SwiftUI

struct LoginView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var email = ""
    @State var password = ""
    @State private var error = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    // Error alert.
    @State private var showAlert = false
    @State private var errorString: String?
    
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
                        viewModel.login(withEmail: email, password: password) { (result) in
                            switch result {
                            case .failure(let error):
                                self.errorString = error.localizedDescription
                                self.showAlert = true
                            case .success( _):
                                break
                            }
                        }
                    }, label: {
                        Text("Sign In")
                            .standardButton()
                    })
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error Message") , message: Text(self.errorString ?? "There was an error."), dismissButton: .default(Text("OK")) {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        )
                    }
                    
                    
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
