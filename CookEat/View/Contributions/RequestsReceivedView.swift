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
                HStack {
                    Text("Requests")
                        .font(.title)
                    Spacer()
                }.padding()
                
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
                                    destination: LazyView(ContributionDetailedView(contribution: contribution)),
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
                Spacer()
            }
        }
    }
}
