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

            DropdownView(imageName: "applescript",title: .constant("Original Ingredients"), text: .constant(contribution.originalIngredients), isExpanded: $isExpandedIngr)
            
            DropdownView(imageName: "list.number",title: .constant("Original Instructions"), text: .constant(contribution.originalInstructions), isExpanded: $isExpandedInstr)
            
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
            
            
        }
        
        
    }
}

//struct ContributionDetailedView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContributionDetailedView(recipe: Contribution)
//    }
//}
