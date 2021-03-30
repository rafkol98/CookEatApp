//
//  FilterButtonView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 07/03/2021.
//

import SwiftUI


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

struct FilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FilterButtonView(selectedOption: .constant(.one))
    }
}
