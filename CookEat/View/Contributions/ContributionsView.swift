//
//  Contributions.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 06/04/2021.
//
//  Struct used to show all the contributions sent.


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
        ScrollView {
            TitleView(text: "Contributions Sent", iconName: "square.stack.3d.up.fill")
            // If user contributed to at least one recipe, show the recipes.
            if viewModel.contributedRecipes.count != 0 {
                VStack{
                    ForEach(viewModel.contributedRecipes) { contribution in
                        VStack {
                            HStack {
                                NavigationLink(
                                    destination: ContributionDetailedView(contribution: contribution, received: false, versionControlOwner: false),
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
                            
                            ContributionDate(contribution: contribution)
                            
                            
                        }
                        Divider()
                    }
                    
                }
            }
            // If user didn't contribute to any recipes, show the appropriate image.
            else  {
                VStack {
                    Spacer().frame(height: 100)
                    Image("contribution_sent")
                        .resizable()
                        .standardImg()
                    
                    Text("No contributions sent...").font(.system(size: 18)).italic()
                    Spacer()
                }
            }
            Spacer()
        }
    }
}
