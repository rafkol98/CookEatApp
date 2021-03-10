//
//  UserProfileView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/03/2021.
//

import SwiftUI

struct UserProfileView: View {
    @State var selectedFilter: FilterOptions = .recipes
    var body: some View {
        ScrollView{
            VStack {
                ProfileHeaderView()
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

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
