//
//  CustomSecureField.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 09/03/2021.
//

import SwiftUI

//Used for entering passwords.
struct CustomSecureField: View {
    @Binding var text: String
    let placeholder: Text
    
    var body: some View {
        ZStack(alignment: .leading){
            if text.isEmpty {
                placeholder
                    .foregroundColor(Color.black)
                    .padding(.leading, 40)
            }
            
            HStack(spacing: 16) {
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                SecureField("", text: $text)
            }
        }
    }
}
