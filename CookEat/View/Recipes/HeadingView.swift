//
//  HeadingView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 09/04/2021.
//

import SwiftUI

struct HeadingView: View {
    let name: String
    let image: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
            Heading(name: name)
        }.padding()
    }
}

