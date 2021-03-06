//
//  Message.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 01/03/2021.
//

import Foundation

struct MockMessage: Identifiable {
    let id: Int
    let imageName: String
    let messageText: String
    let isCurrentUser: Bool
}

let MOCK_MESSAGES: [MockMessage] = [
    .init(id: 0, imageName: "lady", messageText: "Hey", isCurrentUser: false),
    .init(id: 1, imageName: "burger", messageText: "Hey!!!!", isCurrentUser: true),
    .init(id: 2, imageName: "lady", messageText: "Whats up", isCurrentUser: false),
    .init(id: 3, imageName: "burger", messageText: "GOOD and you??", isCurrentUser: true)
]
