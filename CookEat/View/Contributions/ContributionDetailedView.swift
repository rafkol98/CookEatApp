//
//  ContributionDetailedView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 12/04/2021.
//

import SwiftUI
import Kingfisher

struct ContributionDetailedView: View {
    
    let contribution: Contribution
    @State private var isExpandedIngr = false
    @State private var isExpandedInstr = false
    
    var body: some View {
        VStack{
            
            TitleView(text: "Contribution Details")
            
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
                    .padding(.horizontal)
                
                
                   
                Text("By @\(contribution.username)")
                        Spacer()
                    
                
                
            }

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
            
            HStack {
                Button(action: {
                   
                }, label: {
                    Text("Accept")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: .infinity, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.green)
                        .clipShape(Capsule())
                        .padding()
                    
                })
                
                Button(action: {
                   
                }, label: {
                    Text("Decline")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: .infinity, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.red)
                        .clipShape(Capsule())
                        .padding()
                    
                })
            }
        }
        
        
    }
}
