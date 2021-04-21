//
//  InvalidView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 21/04/2021.
//

import SwiftUI

struct InvalidView: View {
    var stringIn : String
    var body: some View {
        HStack {
            Image(systemName: "info.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            Text(stringIn).font(.system(size:14))
        }
    }
}
