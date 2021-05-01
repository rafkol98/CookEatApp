//
//  LazyView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 30/03/2021.
//
//  Load view data only when the user clicks on the view (Do not preload datqa before). This helps
//  make the performance of the app faster.

import SwiftUI


struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}

