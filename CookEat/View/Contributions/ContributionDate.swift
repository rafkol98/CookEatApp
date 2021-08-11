//
//  ContributionDate.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 11/08/2021.
//

import SwiftUI

struct ContributionDate: View {
    let contribution: Contribution
    
    init(contribution: Contribution){
        self.contribution = contribution
    }
    
    var body: some View {
        HStack {
            Image(systemName: "calendar")
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 15, height: 15)
            
            Text(getDate(timestamp: contribution.timestamp))
            Spacer()
        }
        .padding(.horizontal)
    }
}
