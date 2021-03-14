//
//  UserProfileView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/03/2021.
//

import SwiftUI

struct UserProfileView: View {
    @State var selectedFilter: FilterOptions = .recipes
    let user: User
    
    var body: some View {
        ScrollView{
            VStack {
                ProfileHeaderView(user: user)
                    .padding()
                
                FilterButtonView(selectedOption: $selectedFilter)
                    .padding()
            }
            
            ForEach(0..<9) { recipe in
                RecipeCell()
                    .padding()
            }
            
//            .navigationTitle("User")
        }
    }
}
