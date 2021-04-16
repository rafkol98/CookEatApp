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
        ScrollView {
            VStack{
                TitleView(text: "Requests Received", iconName: "tray.and.arrow.down.fill")
                
                if viewModel.receivedRecipes.count != 0 {
                    
                    ForEach(viewModel.receivedRecipes) { contribution in
                        VStack {
                            HStack {
                                KFImage(URL(string: contribution.profileImageUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(120/2)
                                    .shadow(radius: 4)
                                    .padding()
                                VStack {
                                    HStack {
                                        Text("@\(contribution.username) contributed to this recipe:")
                                        Spacer()
                                    }
                                    
                                    NavigationLink(
                                        destination: LazyView(ContributionDetailedView(contribution: contribution, received: true)),
                                        label: {
                                            HStack {
                                                RecipeTitleView(username: .constant(user.username), recipeName: .constant(contribution.recipeName))
                                                Spacer()
                                            }
                                        }).foregroundColor(.black)
                                    
                                }
                                
                            }.padding()
                        }
                        Divider()
                    }
                    
                } else {
                    Image("burger")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 100, height: 100)
                }
                Spacer()
            }
        }
    }
}
