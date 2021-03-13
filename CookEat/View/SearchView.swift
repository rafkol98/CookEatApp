//
//  SearchView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 01/03/2021.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText).padding()
            
            VStack(alignment: .leading) {
                ForEach(0..<19) { _ in
                    HStack {Spacer()}
                    
                    NavigationLink(
                        destination: UserProfileView(),
                        label: {
                            UserCell(user: <#User#>)
                        })
                    UserCell(user: <#User#>)
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

