//
//  Contributions.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/04/2021.
//

import SwiftUI
import Kingfisher


struct ContributionsView: View {
    let user: User
    @ObservedObject var viewModel : ContributeViewModel
    
    
    init(user: User) {
        self.user = user
        self.viewModel = ContributeViewModel(user: user)
    }
    
    var body: some View {
        VStack{
            TitleView(text: "Contributions Sent")
            
            ForEach(viewModel.contributedRecipes) { recipe in
                VStack {
                    
                    HStack {
                        KFImage(URL(string: recipe.originalProfileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 50, height: 50)
                            .cornerRadius(120/2)
                            .shadow(radius: 4)
                            .padding()
                        VStack {
                            HStack {
                                Text("You contributed to this recipe:")
                                Spacer()
                            }
                            
                            HStack {
                                RecipeTitleView(username: .constant(recipe.originalUsername), recipeName: .constant(recipe.recipeName))
                                Spacer()
                            }
                        }
                        
                    }.padding()
                }
            }
            Spacer()
        }
        
    }
}
