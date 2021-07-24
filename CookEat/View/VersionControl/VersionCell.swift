//
//  VersionCell.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 24/07/2021.
//

import SwiftUI
import Kingfisher

struct VersionCell: View {
    
    let contribution: Contribution
    @State var username = ""
    @State var name = ""
    
    // Recipe cell contains recipe title, description and a View Recipe text.
    var body: some View {
        VStack {
            HStack( alignment: .top) {
                VStack(alignment: .leading) {
                    RecipeTitleView(username: $username, recipeName: $name)
                
                    Text("View Contribution").foregroundColor(.red).padding(.trailing).padding(.top)
                    
                }
                
            }.padding(.top)
            
            Divider()
            
        }
        .onAppear {
            username = contribution.username
            name = contribution.recipeName
        }
        
    }
}
