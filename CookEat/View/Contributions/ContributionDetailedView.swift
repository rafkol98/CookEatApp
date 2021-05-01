//
//  ContributionDetailedView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 12/04/2021.
//
//  View showing a contribution in detail.

import SwiftUI
import Kingfisher

struct ContributionDetailedView: View {
    
    let contribution: Contribution
    let received: Bool
    
    @ObservedObject var viewModel: AcceptRejectViewModel
    @State private var isExpandedIngr = false
    @State private var isExpandedInstr = false
    
    
    init(contribution: Contribution, received: Bool) {
        self.contribution = contribution
        self.received = received
        self.viewModel = AcceptRejectViewModel(contribution: contribution)
    }
    
    
    var body: some View {
        VStack{
            TitleView(text: "Contribution Details", iconName: "square.2.stack.3d.top.fill")
            
            if !received {
                HStack {
                    Text("Status:").font(.system(size: 22, weight: .semibold))
                    Text(contribution.status).font(.system(size: 22))
                    Spacer()
                }.padding(.horizontal)
            }
            
            HStack {
                RecipeTitleView(username: .constant(contribution.originalUsername), recipeName: .constant(contribution.recipeName))
                Spacer()
            }
            .padding()
            
            HStack {
                KFImage(URL(string: contribution.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 50, height: 50)
                    .cornerRadius(120/2)
                    .shadow(radius: 4)
                   
                Text("@\(contribution.username)").font(.system(size: 22, weight: .semibold))
                        Spacer()
            }.padding(.horizontal)

            DropdownView(imageName: "applescript",title: .constant("Suggested Ingredients"), text: .constant(contribution.suggestedIngredients), isExpanded: $isExpandedIngr)
            
            DropdownView(imageName: "list.number",title: .constant("Suggested Instructions"), text: .constant(contribution.suggestedInstructions), isExpanded: $isExpandedInstr)
            
            HStack {
                Image(systemName: "plus").frame(width: 1).padding()
                List {
                    Text("Ingredients").font(.headline)
                    ForEach(contribution.addedIngredients, id: \.self) { ingredient in
                        Text(ingredient)
                    }
                    
                    Text("Instructions").font(.headline)
                    ForEach(contribution.addedInstructions, id: \.self) { instruction in
                        Text(instruction)
                    }
                }
            }
            .border(Color(.systemGray2), width: 3)
            .background(Color.green).padding()
            
            
            HStack {
                Image(systemName: "minus").frame(width: 1).padding()
                List {
                    Text("Ingredients").font(.headline)
                    ForEach(contribution.removedIngredients, id: \.self) { ingredient in
                        Text(ingredient)
                    }
                    
                    Text("Instructions").font(.headline)
                    ForEach(contribution.removedInstructions, id: \.self) { instruction in
                        Text(instruction)
                    }
                }
            }
            .border(Color(.systemGray2), width: 3)
            .background(Color.red).padding()
            
            if received {
                //Accept reject
                HStack {
                    Button(action: {
                        viewModel.accept()
                    }, label: {
                        Text("Accept")
                            .adjustButton(with: Color.green)
                    })
                    
                    Button(action: {
                        viewModel.reject()
                    }, label: {
                        Text("Decline")
                            .adjustButton(with: Color.red)
                    })
                }
            }
           
        }
        
        
    }
}
