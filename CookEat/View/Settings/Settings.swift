//
//  Settings.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 24/03/2021.
//

import SwiftUI

struct Settings: View {
    
    //    Get environmentObject of whether user is logged in.
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Button(action: {
            viewModel.signOut()
        }, label: {
            Image(systemName:"plus")
                .resizable()
                .frame(width:32, height:32)
                .padding()
        })
        .background(Color(.systemRed))
        .foregroundColor(.white)
        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        .padding()    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
