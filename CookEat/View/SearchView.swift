//
//  SearchView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 01/03/2021.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @ObservedObject var usersViewModel = UsersViewModel()
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText).padding()
            
            VStack(alignment: .leading) {
//                Loop through users.
                ForEach(usersViewModel.users) { user in
                    HStack {Spacer()}
                    
                    NavigationLink(
                        destination: UserProfileView(user: user),
                        label: {
//                            Place user in a userCell.
                            UserCell(user: user)
                        })
                }
            }.padding(.leading)
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

