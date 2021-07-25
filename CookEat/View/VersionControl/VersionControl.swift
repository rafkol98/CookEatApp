//
//  VersionControl.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 24/07/2021.
//

import SwiftUI

struct VersionControl: View {
    
    let recipe: Recipe
    
    @ObservedObject var viewModel: VersionControlViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var versionControl = false
    
    init(recipe: Recipe ) {
        self.recipe = recipe
        self.viewModel = VersionControlViewModel(recipe: recipe)
    }
    
    //Flag determines if the current user is the owner of the recipe.
    var flag: Bool {
        let currentUid = authViewModel.user?.id
        return currentUid == recipe.uid ? true : false
    }
    
    
    var body: some View {
        VStack {
            TitleView(text: "Version Control", iconName: "clock.arrow.2.circlepath")
            
            if(viewModel.contributions.count != 0) {
                ScrollView {
                    VStack {
                        ForEach(viewModel.contributions.indices) { i in
                            
                            if i == 0 {
                                NavigationLink(
                                    destination: ContributionDetailedView(contribution: viewModel.contributions[i], received: false, versionControlOwner: false),
                                    label: {
                                        HStack {
                                            VersionCell(contribution: viewModel.contributions[i]).foregroundColor(.red)
                                        }
                                    })
                            } else {
                                NavigationLink(
                                    destination: ContributionDetailedView(contribution: viewModel.contributions[i], received: false, versionControlOwner: flag),
                                    label: {
                                        VersionCell(contribution: viewModel.contributions[i]).foregroundColor(.black)
                                    })
                            }
                        }
                    }.padding()
                }
            }
            Spacer()
        }
        .onAppear {
            viewModel.fetchVersions()
        }
    }
}
