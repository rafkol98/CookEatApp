//
//  LazyView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 30/03/2021.
//

import SwiftUI

//Load view when it comes to view.
struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}

