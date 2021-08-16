//
//  ChangePasswordView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 16/08/2021.
//

import SwiftUI

struct ChangePasswordView: View {
    @State var currentPassword: String = ""
    @State var newPassword: String = ""
    @State var confirmPassword: String = ""
    
    var body: some View {
        
        Form {
            SecureField("CurrentPassword", text: $currentPassword)
            SecureField("New Password", text: $newPassword)
            SecureField("Confirm Password", text: $confirmPassword)
        }
        .padding()
    }
}

