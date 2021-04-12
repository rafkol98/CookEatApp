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
            TitleView(text: "Contributions Sent", iconName: "square.stack.3d.up.fill")
            
            ForEach(viewModel.contributedRecipes) { contribution in
                VStack {
                    HStack {
                        KFImage(URL(string: contribution.originalProfileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 50, height: 50)
                            .cornerRadius(120/2)
                            .shadow(radius: 4)
                            .padding()
                        NavigationLink(
                            destination: LazyView(ContributionDetailedView(contribution: contribution, received: false)),
                            label: {
                                VStack {
                                    HStack {
                                        RecipeTitleView(username: .constant(contribution.originalUsername), recipeName: .constant(contribution.recipeName))
                                        Spacer()
                                    }
                                    HStack{
                                        Text("Status:").font(.system(size: 18, weight: .medium))
                                        Text("\(contribution.status)")
                                        Spacer()
                                    }
                                }
                            }).foregroundColor(.black)
                        
                        
                    }.padding()
                    
                }
                Divider()
            }
            Spacer()
        }
        
    }
}
