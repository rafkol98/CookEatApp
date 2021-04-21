//
//  functions.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 21/04/2021.
//

import Foundation
import SwiftUI

// Check if string is invalid
func invalid(varIn: String, minBoundary: Int, maxBoundary : Int) -> Bool {
    return varIn.isEmpty || varIn.count < minBoundary || varIn.count > maxBoundary
}

// Check if string is invalid
func invalidPassword(varIn: String, boundary: Int) -> Bool {
    return varIn.isEmpty || varIn.count < boundary
}

// Change colour of border if valid
func validBorder(varIn: String, boundary: Int) -> Color {
    //Check if input is valid.
    return (varIn.count <= boundary) ? .green : .red
}

// Check if email is valid
func isValidEmail(email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

// Check if Array is invalid
func invalidArray(varIn: Array<String>) -> Bool {
    return varIn.isEmpty
}

// Check if two strings are equal
func equalString(stringOne: String, stringTwo: String) -> Bool {
    return stringOne == stringTwo
}
