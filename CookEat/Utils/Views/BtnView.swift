//
//  BtnView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 16/04/2021.
//

import SwiftUI

struct BtnView: View {
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
            HStack {
                Image(systemName: "livephoto")
                Text("Alo")
            }.standardButton()
        }
    }
}

struct BtnView_Previews: PreviewProvider {
    static var previews: some View {
        BtnView()
    }
}
