//
//  HomeView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 01/03/2021.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        ZStack(){
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.white))
                .frame(width: 400, height: 200)
                .scaledToFit()
                .shadow(radius: 4 )
            
        
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Trending")
                        .font(.system(size: 28))
                        .foregroundColor(.red)
                        .multilineTextAlignment(.leading)
                        .padding()
                    
                    Text("See what's hot right now")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .padding()
                    
                }
            }
                
                
        }
       
       
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
