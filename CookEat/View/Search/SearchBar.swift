//
//  SearchBar.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 01/03/2021.
//
//  The style of the searchbar.

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        // Searchbar style.
        HStack {
            TextField("Search...",text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(HStack{
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                })
        }
        .padding(.horizontal, 10)
    }
}
