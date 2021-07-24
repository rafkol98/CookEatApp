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
    
    @State private var versionControl = false
    
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
                            
                            // Button used to open version control of a recipe.
                            Button(action: {
                                // open sheet
                                versionControl.toggle()
                            }) {
                                //Place user in a userCell.
                                VersionCell(contribution: contribution).foregroundColor(.black)
                            }
                            // Open add new recipe view as a sheet.
                            .sheet(isPresented: $versionControl, content: {
                                ContributionDetailedView(contribution: contribution, received: false)
                            })
                            
                            
                            //                            NavigationLink(
                            //                                destination: ContributionDetailedView(contribution: contribution, received: false),
                            //                                label: {
                            //                                    //Place user in a userCell.
                            //                                    VersionCell(contribution: contribution)
                            //                                }).foregroundColor(.black)
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
