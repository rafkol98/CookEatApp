//
//  Title.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 12/04/2021.
//

import SwiftUI

struct TitleView: View {
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 28, weight: .semibold))
            
            
            Spacer()
        }.padding()
        
    }
}
