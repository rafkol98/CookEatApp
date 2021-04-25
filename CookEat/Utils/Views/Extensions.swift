//
//  Extensions.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 11/04/2021.
//

import SwiftUI

// Standard button style.
struct StandardBtn: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 300, height: 45)
            .background(Color.red)
            .clipShape(Capsule())
            .padding()
    }
}

// Button that adjusts its size according to the space available.
struct adjustBtn: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: .infinity, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(color)
            .clipShape(Capsule())
            .padding()
        
    }
}

// Modifier for the input boxes.
struct inputMod: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.init(white: 0.5, alpha: 0.05)))
            .cornerRadius(10)
            .padding(.horizontal)
        
    }
}

// Modifier for the images that appear on the app.
struct stdImg: ViewModifier {

    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .clipped()
            .frame(width: 180, height: 180)
        
    }
}


//Create functions that will be callable from the structs.
extension View {
    func standardButton() -> some View {
        self.modifier(StandardBtn())
    }
    
    func adjustButton(with color: Color) -> some View {
        self.modifier(adjustBtn(color: color))
    }
    
    func inputModifier() -> some View {
        self.modifier(inputMod())
    }
    
    func standardImg() -> some View {
        self.modifier(stdImg())
    }
}
