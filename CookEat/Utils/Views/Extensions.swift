//
//  Extensions.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 11/04/2021.
//

import SwiftUI

//extension Collection where Indices.Iterator.Element == Index {
//   public subscript(safe index: Index) -> Iterator.Element? {
//     return (startIndex <= index && index < endIndex) ? self[index] : nil
//   }
//}


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

struct dynamicBtn: ViewModifier {
    var color: Color
    var width: Int
    var height: Int
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 300, height: 45)
            .background(color)
            .clipShape(Capsule())
            .padding()
    }
}

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

//struct rejectBtn: ViewModifier {
//    var color: Color
//
//    func body(content: Content) -> some View {
//        content
//            .font(.headline)
//            .foregroundColor(.white)
//            .frame(width: 300, height: 45)
//            .background(color)
//            .clipShape(Capsule())
//            .padding()
//    }
//}



extension View {
    func standardButton() -> some View {
        self.modifier(StandardBtn())
    }
    
    func dynamicButton(with color: Color, width: Int, height: Int) -> some View {
        self.modifier(dynamicBtn(color: color, width: width, height: height))
    }
    
    func adjustButton(with color: Color) -> some View {
        self.modifier(adjustBtn(color: color))
    }
}
