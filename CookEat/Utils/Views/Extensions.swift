//
//  Extensions.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 11/04/2021.
//

import SwiftUI

extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
