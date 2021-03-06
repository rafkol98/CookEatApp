//
//  ChangePasswordView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 16/08/2021.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var currentPassword: String = ""
    @State var newPassword: String = ""
    @State var confirmPassword: String = ""
    
    // Error alert.
    @State private var showAlert = false
    @State private var errorString: String?
    
    
    @ObservedObject var viewModel = SettingsViewModel()
    
    
    //Disable button
    var disableButton: Bool {
        return invalid(varIn: currentPassword, minBoundary: 6, maxBoundary: 40) || invalid(varIn: newPassword, minBoundary: 6, maxBoundary: 40) || invalid(varIn: confirmPassword, minBoundary: 6, maxBoundary: 40) || !equalString(stringOne: newPassword, stringTwo: confirmPassword)
    }
    
    //Add red color to the submit button when all the inputs are valid.
    var buttonColor: Color {
        return disableButton ? .accentColor : .red
    }
    
    var body: some View {
        ScrollView {
            
            VStack {
                TitleView(text: "Change Password", iconName: "ellipsis.rectangle")
                    .padding(.top)
                
                CustomSecureField(text: $currentPassword    , placeholder: Text("Current Password..."))
                    .inputModifier()
                
                if (invalid(varIn: currentPassword, minBoundary: 6, maxBoundary:40)) {
                    InvalidView(stringIn: "Ensure that the Current Password entered is between 6 and 40 characters.")
                        .padding()
                }
                
                CustomSecureField(text: $newPassword    , placeholder: Text("New Password..."))
                    .inputModifier()
                
                if (invalid(varIn: newPassword, minBoundary: 6, maxBoundary:40)) {
                    InvalidView(stringIn: "Ensure that your New Password is between 6 and 40 characters.")
                        .padding()
                }
                
                CustomSecureField(text: $confirmPassword    , placeholder: Text("Confirm New Password..."))
                    .inputModifier()
                
                if (invalid(varIn: confirmPassword, minBoundary: 6, maxBoundary:40) || !equalString(stringOne: newPassword, stringTwo: confirmPassword)) {
                    InvalidView(stringIn: "Ensure that the password matches the one entered above and is between 6 and 40 characters.")
                        .padding()
                }
                
                
                Button(action: {
                    // Change password of user.
                    viewModel.changePassword(currentPassword: currentPassword, newPassword: newPassword, confirmPassword: confirmPassword) { (result) in
                        switch result {
                        case .failure(let error):
                            self.errorString = error.localizedDescription
                        case .success( _):
                            break
                        }
                        self.showAlert = true
                    }
                }, label: {
                    Text("Change Password")
                        .adjustButton(with: buttonColor)
                })
                .disabled(disableButton)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Message") , message: Text(self.errorString ?? "Success. Your password was changed successfully."), dismissButton: .default(Text("OK")) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    )
                }
                Spacer()
            }
        }
    }
}

