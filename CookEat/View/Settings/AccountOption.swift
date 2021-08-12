//
//  SettingsOption.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 03/04/2021.
//
//  Used to display an option in the settings page.

import SwiftUI

struct AccountOption: View {
   
    let icon: String
    let text: String
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    
                
                Text(text)
                    .font(.system(size: 22, weight: .semibold))
                    
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
            }.padding()
            Divider()
        }
        
    }
}
