//
//  FeedView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 28/02/2021.
//

import SwiftUI

struct FeedView: View {
//    Is showing new recipe flag.
    @State var isShowingNewRecipeView = false
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack {
                    ForEach(0..<10) { _ in
                        RecipeCell()

                    }
                }.padding()
            }
            
//            On button pressed, make the isShowingNewRecipeView flag true.
            Button(action: {isShowingNewRecipeView.toggle()}, label: {
                Image(systemName:"plus")
                    .resizable()
                    .frame(width:32, height:32)
                    .padding()
            })
            .background(Color(.systemRed))
            .foregroundColor(.white)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .padding()
//            On click of add new recipe button show newRecipeView.
            .fullScreenCover(isPresented: $isShowingNewRecipeView) {
                NewRecipeView(isPresented: $isShowingNewRecipeView)
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
