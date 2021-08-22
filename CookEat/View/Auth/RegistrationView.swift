//
//  RegistrationView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 09/03/2021.
//
//  Registration - Sign up view.

import SwiftUI

struct RegistrationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var fullname = ""
    @State var username = ""
    @State var email = ""
    @State var password = ""
    @State var addImage = false
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    
    // Create instance of AuthViewModel
    @EnvironmentObject var viewModel: AuthViewModel
    
    // Error alert.
    @State private var showAlert = false
    @State private var errorString: String?
    
    // Convert a ui image into a SwiftUI image.
    func loadImage() {
        guard let selectedImage = selectedUIImage else {return}
        image = Image(uiImage: selectedImage)
    }
    
    // Disable button
    var disableButton: Bool {
        return !isValidEmail(email: email) || invalid(varIn: password, minBoundary: 6, maxBoundary: 40) || invalid(varIn: username, minBoundary: 5, maxBoundary: 20) || invalid(varIn: fullname, minBoundary: 5, maxBoundary: 50) || selectedUIImage==nil
    }
    
    // Add red color to the submit button when all the inputs are valid.
    var buttonColor: Color {
        return disableButton ? .accentColor : .red
    }
    
    var body: some View {
        ScrollView {
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
                
                if (selectedUIImage==nil) {
                    InvalidView(stringIn: "Upload a profile picture").padding()
                }
                
                // Email, fullname, username and password fields.
                VStack {
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .inputModifier()
                    if (!isValidEmail(email: email)) {
                        InvalidView(stringIn: "Enter a valid email")
                            .padding()
                    }
                    
                    CustomTextField(text: $fullname, placeholder: Text("Full Name"), imageName: "textformat")
                        .inputModifier()
                    if (invalid(varIn: fullname, minBoundary: 5, maxBoundary:50)) {
                        InvalidView(stringIn: "Between 5 to 50 characters")
                            .padding()
                    }
                    
                    CustomTextField(text: $username, placeholder: Text("Username"), imageName: "person")
                        .inputModifier()
                    if (invalid(varIn: username, minBoundary:5, maxBoundary:20)) {
                        InvalidView(stringIn: "Between 5 to 20 characters")
                            .padding()
                    }
                    
                    CustomSecureField(text: $password, placeholder: Text("Password..."))
                        .inputModifier()
                    if (invalid(varIn: password, minBoundary:6, maxBoundary: 40)) {
                        InvalidView(stringIn: "Between 6 to 40 characters")
                            .padding()
                    }
                    
                }
                
                // Sign up button
                Button(action: {
                    guard let image = selectedUIImage else { return }
                    viewModel.registerUser(email: email, password: password, username: username, fullname: fullname, profileImage: image) { (result) in
                        switch result {
                        case .failure(let error):
                            self.errorString = error.localizedDescription
                            self.showAlert = true
                        case .success( _):
                            break
                        }
                       
                    }
                }, label: {
                    Text("Sign Up")
                        .adjustButton(with: buttonColor)
                })
                .disabled(disableButton)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error Message") , message: Text(self.errorString ?? "There was an error."), dismissButton: .default(Text("OK")) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    )
                }
                
                
            }
            .padding()
        }
    }
}

