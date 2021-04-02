//
//  Settings.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 24/03/2021.
//

import SwiftUI
import Kingfisher


struct Settings: View {
    
    //    Get environmentObject of whether user is logged in.
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack{
            HStack{
                KFImage(URL(string: viewModel.user!.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 120, height: 120)
                    .cornerRadius(120/2)
                    .shadow(radius: 10)
                    .padding()

                Text(viewModel.user!.username)
                    .font(.system(size: 22, weight: .semibold))
                Spacer()

            }
            .padding()
        

            SettingsOption(icon: "person.crop.circle", text: "View Profile")
             Divider()
            
            SettingsOption(icon: "square.stack.3d.up.fill", text: "Contributions")
            Divider()
          
            SettingsOption(icon: "tray.and.arrow.down.fill", text: "Requests Received")
            Divider()
            
            Spacer()
            Button(action: {
                viewModel.signOut()
            }, label: {
                Text("Sign out")
                    .font(.system(size: 22, weight: .semibold))
                    .padding()
                    .frame(width: 300, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
               
            })
            .background(Color(.systemRed))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding()    }
        }
        
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
