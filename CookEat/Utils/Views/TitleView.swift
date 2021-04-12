//
//  Title.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 12/04/2021.
//

import SwiftUI

struct TitleView: View {
    let text: String
    let iconName: String
    
    var body: some View {
        HStack {
            Image(systemName:iconName).imageScale(.large)
            Text(text)
                .font(.system(size: 28, weight: .semibold))
            
            
            Spacer()
        }.padding()
        
    }
}
