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
    @State var addImage = false
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    
    //    Create instance of AuthViewModel
    @EnvironmentObject var viewModel: AuthViewModel
    
    //convert a ui image into a SwiftUI image.
    func loadImage() {
        guard let selectedImage = selectedUIImage else {return}
        image = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        
        ZStack{
            
            VStack {
                Button(action: { addImage.toggle() }, label: {
                    ZStack {
                        if let image = image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .cornerRadius(75)
                                .padding()
                            
                        } else {
                            Image("add_photo")
                                .resizable()
                                // Rendering mode template allows us to add a colour to the image.
                                .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .padding()
                                .foregroundColor(.red)
                        }
                        
                    }
                    
                }).sheet(isPresented: $addImage, onDismiss: loadImage, content: {
                    ImagePicker(image: $selectedUIImage)
                })
                
                // Email, fullname, username and password fields.
                VStack {
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .inputModifier()
                    if (!isValidEmail(email: email)) {
                        InvalidView(stringIn: "Ensure that the entered email is valid")
                            .padding()
                    }
                    
                    CustomTextField(text: $fullname, placeholder: Text("Full Name"), imageName: "textformat")
                        .inputModifier()
                    if (invalid(varIn: fullname, minBoundary: 5, maxBoundary:50)) {
                        InvalidView(stringIn: "Ensure that full name is between 5 to 50 characters")
                            .padding()
                    }
                    
                    CustomTextField(text: $username, placeholder: Text("Username"), imageName: "person")
                        .inputModifier()
                    if (invalid(varIn: username, minBoundary:5, maxBoundary:20)) {
                        InvalidView(stringIn: "Ensure that username is between 5 to 20 characters")
                            .padding()
                    }
                    
                    CustomSecureField(text: $password, placeholder: Text("Password..."))
                        .inputModifier()
                    if (invalid(varIn: password, minBoundary:6, maxBoundary: 40)) {
                        InvalidView(stringIn: "Ensure that password is between 6 to 40 characters")
                            .padding()
                    }
                    
                }
                
                // Sign up button
                Button(action: {
                    guard let image = selectedUIImage else { return }
                    viewModel.registerUser(email: email, password: password, username: username, fullname: fullname, profileImage: image)
                }, label: {
                    Text("Sign Up")
                        .standardButton()
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
