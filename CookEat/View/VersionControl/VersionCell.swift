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
                VStack(alignment: .leading) {
                    HStack {
                        VStack {
                            KFImage(URL(string: contribution.profileImageUrl))
                                .resizable()
                                .scaledToFill()
                                .clipped()
                                .frame(width: 60, height: 60)
                                .cornerRadius(120/2)
//                            Text("@\(contribution.username)").font(.system(size: 17))
                        }
                        Text(getDate(timestamp: contribution.timestamp)).font(.system(size: 20)).padding()
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                    }
                }
            Divider()
        }
        .onAppear {
            username = contribution.username
            name = contribution.recipeName
        }
        
    }
}
