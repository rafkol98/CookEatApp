//
//  FeedView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 28/02/2021.
//

import SwiftUI

struct FeedView: View {
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack {
                    ForEach(0..<10) { _ in
//                        NavigationLink
                        NavigationLink(
                            destination: RecipeDetails(),
                            label: {
    //                            Place user in a userCell.
                                RecipeCell()
                            }).foregroundColor(.black)
                        

                    }
                }.padding()
            }
            
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
