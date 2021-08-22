//
//  ChangeUsernameView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 22/08/2021.
//

import SwiftUI

struct ChangeEmailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var newEmail: String = ""
    @State var confirmNewEmail: String = ""
    @State var password: String = ""
    
    // Error alert.
    @State private var showAlert = false
    @State private var errorString: String?
    
    @ObservedObject var viewModel = SettingsViewModel()
    
    //Disable button
    var disableButton: Bool {
        return !isValidEmail(email: newEmail) || !isValidEmail(email: confirmNewEmail)  || invalid(varIn: password, minBoundary: 6, maxBoundary: 40) || !equalString(stringOne: newEmail, stringTwo: confirmNewEmail)
    }
    
    //Add red color to the submit button when all the inputs are valid.
    var buttonColor: Color {
        return disableButton ? .accentColor : .red
    }
    
    
    var body: some View {
        ScrollView {
            VStack {
                TitleView(text: "Change Email", iconName: "envelope")
                    .padding(.top)
                
                CustomTextField(text: $newEmail, placeholder: Text("New Email..."), imageName: "person")
                    .inputModifier()
                
                if (!isValidEmail(email: newEmail)) {
                    InvalidView(stringIn: "Please enter a valid email address.")
                        .padding()
                }
                
                CustomTextField(text: $confirmNewEmail, placeholder: Text("Confirm New Email..."), imageName: "person")
                    .inputModifier()
                
                if (!isValidEmail(email: newEmail) || !equalString(stringOne: newEmail, stringTwo: confirmNewEmail)) {
                    InvalidView(stringIn: "Please enter the same email address as above.")
                        .padding()
                }
                
                CustomSecureField(text: $password, placeholder: Text("Password..."))
                    .inputModifier()
                
                if (invalid(varIn: password, minBoundary: 6, maxBoundary:40)) {
                    InvalidView(stringIn: "Ensure that the Current Password entered is between 6 and 40 characters.")
                        .padding()
                }
                
                Button(action: {
                    viewModel.updateEmail(newEmail: newEmail, confirmNewEmail: confirmNewEmail, password: password ) { (result) in
                        switch result {
                        case .failure(let error):
                            self.errorString = error.localizedDescription
                        case .success( _):
                            break
                        }
                        self.showAlert = true
                    }
                }, label: {
                    Text("Update Email")
                        .adjustButton(with: buttonColor)
                })
                .disabled(disableButton)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Message") , message: Text(self.errorString ?? "Success. Your email was changed successfully."), dismissButton: .default(Text("OK")) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    )
                }
                
            }
        }
    }
}
