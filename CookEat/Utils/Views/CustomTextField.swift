//
//  CustomTextField.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 09/03/2021.
//

import SwiftUI

//CustomTextField that gets input and shows an image on the left.
struct CustomTextField: View {
    @Binding var text: String
    let placeholder: Text
    let imageName: String
    
    var body: some View {
        ZStack(alignment: .leading){
            if text.isEmpty {
                placeholder
                    .foregroundColor(Color.black)
                    .padding(.leading, 40)
            }
            
            HStack(spacing: 16) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                TextField("", text: $text)
            }
        }
    }
}
