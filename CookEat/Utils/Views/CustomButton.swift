//
//  Button.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 05/04/2021.
//

import SwiftUI

struct CustomButton {
    
    var name: String = ""
    
    init(name: String) {
        self.name = name
    }

    var body: some View {
        
    Text(name)
        .font(.headline)
        .foregroundColor(.white)
        .frame(width: 360, height: 50)
        .background(Color.red)
        .clipShape(Capsule())
        .padding()
    }
}
