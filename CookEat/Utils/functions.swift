//
//  functions.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 21/04/2021.
//

import Foundation
import SwiftUI

// Check if string is invalid
func invalid(varIn: String, boundary: Int) -> Bool {
    return varIn.isEmpty || varIn.count > boundary
}

// Change colour of border if valid
func validBorder(varIn: String, boundary: Int) -> Color {
    //Check if input is valid.
    return (varIn.count <= boundary) ? .green : .red
}

// Check if Array is invalid
func invalidArray(varIn: Array<String>) -> Bool {
    return varIn.isEmpty
}
