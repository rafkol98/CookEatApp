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
    
    init(recipe: Recipe ) {
        self.recipe = recipe
        self.viewModel = VersionControlViewModel(recipe: recipe)
    }
    
    var body: some View {
        VStack {
            TitleView(text: "Version Control", iconName: "clock.arrow.2.circlepath")
            
            if(viewModel.contributions.count != 0) {
                ScrollView {
                    VStack {
                        ForEach(viewModel.contributions) { contribution in
                            NavigationLink(
                                destination: ContributionDetailedView(contribution: contribution, received: false),
                                label: {
                                    //Place user in a userCell.
                                    VersionCell(contribution: contribution)
                                }).foregroundColor(.black)
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
