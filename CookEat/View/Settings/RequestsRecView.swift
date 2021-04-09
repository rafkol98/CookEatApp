//
//  RequestsRecView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 10/04/2021.
//

import SwiftUI
import Kingfisher

struct RequestsRecView: View {
    
    let user: User
    @ObservedObject var viewModel : SuggestedViewModel
    
    
    init(user: User) {
        self.user = user
        self.viewModel = SuggestedViewModel(user: user)
    }
    
    var body: some View {
        VStack{
            HStack {
                Text("Requests")
                    .font(.title)
                Spacer()
            }.padding()
            
            ForEach(viewModel.suggestedRecipes) { recipe in
                VStack {
                    HStack{
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 56, height: 56)
                            .cornerRadius(120/2)
                            .shadow(radius: 10)
                            .padding()
                        
                        Text("\(recipe.username) contributed to this recipe:")
                        
                        Spacer()
                    }
                    HStack {
                        RecipeTitleView(username: .constant(user.username), recipeName: .constant(recipe.recipeName))
                        Spacer()
                    }.padding()
                }
               
                
            }
            
            
            Spacer()
        }
        
    }
}
