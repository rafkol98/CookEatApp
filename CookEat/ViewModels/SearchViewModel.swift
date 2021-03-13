//
//  SearchViewModel.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 13/03/2021.
//

import SwiftUI
import Firebase

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        COLLECTION_USERS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            documents.forEach { document in
                let user = User(dictionary: document.data())
//                append user to user array.
                self.users.append(user)
            }
        }
    }
    
}
