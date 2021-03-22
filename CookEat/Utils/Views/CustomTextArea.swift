//
//  CustomTextArea.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 22/03/2021.
//

import SwiftUI

struct CustomTextArea: View {
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
                TextEditor(text: $text)
                
            }
        }
    }
}
