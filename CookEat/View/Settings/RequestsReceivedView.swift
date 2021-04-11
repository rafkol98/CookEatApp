//
//  RequestsRecView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 10/04/2021.
//

import SwiftUI
import Kingfisher

struct RequestsReceivedView: View {
    
    let user: User
    @ObservedObject var viewModel : ContributeViewModel
    
    
    init(user: User) {
        self.user = user
        self.viewModel = ContributeViewModel(user: user)
    }
    
    var body: some View {
        VStack{
            HStack {
                Text("Requests")
                    .font(.title)
                Spacer()
            }.padding()
            
            ForEach(viewModel.receivedRecipes) { recipe in
                VStack {
                    
                    HStack {
                        KFImage(URL(string: recipe.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 50, height: 50)
                            .cornerRadius(120/2)
                            .shadow(radius: 4)
                            .padding()
                        VStack {
                            HStack {
                                Text("@\(recipe.username) contributed to this recipe:")
                                Spacer()
                            }
                            
                            HStack {
                                RecipeTitleView(username: .constant(user.username), recipeName: .constant(recipe.recipeName))
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
