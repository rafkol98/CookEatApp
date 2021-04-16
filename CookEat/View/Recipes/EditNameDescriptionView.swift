//
//  EditNameDescription.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 16/04/2021.
//

import SwiftUI

struct EditNameDescriptionView: View {
    @Binding var name: String
    @Binding var description: String
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            SmallInput(name: "New Recipe Name", existingText: viewModel.user?.username ?? "Error", iconName: "textformat", stringIn: $name, valid: Color.green)
            
            LargeInput(name: "New Description",  iconName: "bubble.right", stringIn: $description, valid: Color.green)
        }
    }
}
