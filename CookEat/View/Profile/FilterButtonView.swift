//
//  FilterButtonView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 07/03/2021.
//
//  Used to filter between two different options.

import SwiftUI

// Switch between recipes and likes, used for the profile of a user.
enum FilterOptions: Int, CaseIterable {
    case one
    case two
  
    
    var title : String {
        switch self {
        case .one: return "Recipes"
        case .two: return "Likes"
        }
    }
}

// Switch between recipes and profiles, used for the search feature.
enum FilterOptions2: Int, CaseIterable {
    case one
    case two
  
    
    var title : String {
        switch self {
        case .one: return "Recipes"
        case .two: return "Profiles"
        }
    }
}

//TODO: fix repetitiveness!!
struct FilterButtonView: View {
    @Binding var selectedOption: FilterOptions
    
    private let underlineWidth = UIScreen.main.bounds.width / CGFloat(FilterOptions.allCases.count)
    
    
    private var padding: CGFloat {
        let rawValue = CGFloat(selectedOption.rawValue)
        let count = CGFloat(FilterOptions.allCases.count)
        return ((UIScreen.main.bounds.width / count) * rawValue) + 16
        
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                ForEach(FilterOptions.allCases, id: \.self) { option in
                    Button(action: {
                        self.selectedOption = option
                    }, label: {
                        Text(option.title)
                            .frame(width: underlineWidth)
                            .foregroundColor(.red)
                    })
                    
                    
                }
            }
            Rectangle()
                .frame(width: underlineWidth - 32, height: 3, alignment: .center)
                .foregroundColor(.red)
                .padding(.leading, padding)
                .animation(.spring())
        }
    }
}

struct FilterButtonView2: View {
    @Binding var selectedOption: FilterOptions2
    
    private let underlineWidth = UIScreen.main.bounds.width / CGFloat(FilterOptions2.allCases.count)
    
    
    private var padding: CGFloat {
        let rawValue = CGFloat(selectedOption.rawValue)
        let count = CGFloat(FilterOptions2.allCases.count)
        return ((UIScreen.main.bounds.width / count) * rawValue) + 16
        
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                ForEach(FilterOptions2.allCases, id: \.self) { option in
                    Button(action: {
                        self.selectedOption = option
                    }, label: {
                        Text(option.title)
                            .frame(width: underlineWidth)
                            .foregroundColor(.red)
                    })
                    
                    
                }
            }
            Rectangle()
                .frame(width: underlineWidth - 32, height: 3, alignment: .center)
                .foregroundColor(.red)
                .padding(.leading, padding)
                .animation(.spring())
        }
    }
}
