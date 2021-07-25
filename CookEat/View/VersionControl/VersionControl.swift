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
                            
                            NavigationLink(
                                destination: ContributionDetailedView(contribution: contribution, received: false),
                                label: {
                                    VersionCell(contribution: contribution).foregroundColor(.black)
                                })
                            
                            
                            
//                            // Button used to open version control of a recipe.
//                            Button(action: {
//                                // open sheet
//                                versionControl.toggle()
//                            }) {
//                                // Show contribution in a cell.
//                                VersionCell(contribution: contribution).foregroundColor(.black)
//                            }
//                            // Open detaailed contribution view as a sheet.
//                            .sheet(isPresented: $versionControl, content: {
//                                ContributionDetailedView(contribution: contribution, received: false)
//                            })
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
