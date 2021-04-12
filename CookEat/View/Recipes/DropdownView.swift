//
//  DropdownView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 19/03/2021.
//

import SwiftUI



struct DropdownView: View {
    let imageName: String
    @Binding var title: String
    @Binding var text: Array<String>
    @Binding var isExpanded: Bool
    
    
    var body: some View {
        
        HStack{
            Image(systemName: imageName)
            DisclosureGroup(title, isExpanded: $isExpanded) {
                    ScrollView{
                        TextEditor(text: .constant(text.joined(separator:", \n")))
                            .frame(width: .infinity, height: 80)
                            .padding(.horizontal)
                            .foregroundColor(Color(red: 40/255, green: 40/255, blue: 40/255))
                    }
            }.font(.system(size: 18))
            
        }
        
        .accentColor(.red)
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray2), lineWidth: 3)
                
               
        )
        .padding()
        
    }
}
