//
//  UserCell.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 02/03/2021.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
// HStack containing picture of user and their username and full name.
        HStack(spacing: 15) {
            Image("lady")
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 56, height: 56)
                .cornerRadius(28)
// Put username and last name on top of each other.
            VStack(alignment: .leading, spacing: 4){
                Text("@UserName")
                    .font(.system(size: 16, weight: .semibold))
                
                Text("Name Last")
                    .font(.system(size: 14))
            }
            .foregroundColor(.black)
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell()
    }
}
