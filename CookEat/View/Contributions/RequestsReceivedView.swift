//
//  RequestsRecView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 10/04/2021.
//
//  Struct used to show all the requests received.

import SwiftUI
import Kingfisher

struct RequestsReceivedView: View {
    
    let user: User
    @ObservedObject var viewModel : ContributeViewModel
    @State var selectedFilter: FilterOptions3 = .one
    
    
    init(user: User) {
        self.user = user
        self.viewModel = ContributeViewModel(user: user)
    }
    
    var body: some View {
        
        TitleView(text: "Requests Received", iconName: "tray.and.arrow.down.fill")
        
        FilterButtonView3(selectedOption: $selectedFilter)
        
        switch selectedFilter {
        
        // Case two is users profiles.
        case .one:
            
            // If requests received are not equal to 0, then display them.
            if viewModel.receivedRecipes.count != 0 {
                ScrollView {
                    VStack{
                        
                        ForEach(viewModel.receivedRecipes) { contribution in
                            VStack {
                                HStack {
                                    KFImage(URL(string: contribution.profileImageUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .clipped()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(120/2)
                                        .padding()
                                    VStack {
                                        HStack {
                                            Text("@\(contribution.username) contributed to this recipe:")
                                            Spacer()
                                        }
                                        
                                        NavigationLink(
                                            destination: ContributionDetailedView(contribution: contribution, received: true, versionControlOwner: false),
                                            label: {
                                                HStack {
                                                    RecipeTitleView(username: .constant(user.username), recipeName: .constant(contribution.recipeName))
                                                    Spacer()
                                                }
                                            })
                                            .foregroundColor(.black)
                                    }
                                    
                                }.padding(.top)
                                ContributionDate(contribution: contribution)
                            }
                            Divider()
                        }
                        Spacer()
                    }
                }
            }
            // If the user received no requests, display appropriate image.
            else {
                VStack {
                    Spacer().frame(height: 100)
                    Image("req_received")
                        .resizable()
                        .standardImg()
                    
                    Text("No requests received...").font(.system(size: 16)).italic()
                    Spacer()
                }
            }
            
            
            
        case .two:
            if viewModel.pastReceivedRecipes.count != 0 {
                ScrollView {
                    VStack{
                        
                        ForEach(viewModel.pastReceivedRecipes) { contribution in
                            VStack {
                                HStack {
                                    KFImage(URL(string: contribution.profileImageUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .clipped()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(120/2)
                                        .padding()
                                    VStack {
                                        HStack {
                                            Text("@\(contribution.username) contributed to this recipe:")
                                            Spacer()
                                        }
                                        
                                        NavigationLink(
                                            destination: ContributionDetailedView(contribution: contribution, received: true, versionControlOwner: false),
                                            label: {
                                                HStack {
                                                    RecipeTitleView(username: .constant(user.username), recipeName: .constant(contribution.recipeName))
                                                    Spacer()
                                                }
                                            })
                                            .foregroundColor(.black)
                                    }
                                    
                                }.padding(.top)
                                ContributionDate(contribution: contribution)
                            }
                            Divider()
                        }
                        Spacer()
                    }
                }
            }
            // If the user received no requests, display appropriate image.
            else {
                VStack {
                    Spacer().frame(height: 100)
                    Image("req_received")
                        .resizable()
                        .standardImg()
                    
                    Text("No past requests were maade...").font(.system(size: 16)).italic()
                    Spacer()
                }
            }
            
        }
    }
    
}
