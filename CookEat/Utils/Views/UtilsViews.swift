//
//  UtilsViews.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 21/04/2021.
//
//  Contains various small structs used throughout the application e.g. titles for every struct.

import SwiftUI

//CustomTextField that gets input and shows an image on the left.
struct CustomTextField: View {
    @Binding var text: String
    let placeholder: Text
    let imageName: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundColor(Color.black)
                    .padding(.leading, 40)
            }
            
            HStack(spacing: 16) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                TextField("", text: $text)
            }
        }
    }
}

//Used for entering passwords.
struct CustomSecureField: View {
    @Binding var text: String
    let placeholder: Text
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundColor(Color.black)
                    .padding(.leading, 40)
            }
            
            HStack(spacing: 16) {
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                SecureField("", text: $text)
                    .accessibilityLabel("password")
            }
        }
    }
}

//Add a title to a page.
struct TitleView: View {
    let text: String
    let iconName: String
    
    var body: some View {
        HStack {
            Image(systemName:iconName).imageScale(.large)
            Text(text)
                .font(.system(size: 28, weight: .semibold))
            
            
            Spacer()
        }
        .padding()
        
    }
}

//Create a heading.
struct HeadingView: View {
    let name: String
    let image: String
    
    var body: some View {
        HStack {
            Image(systemName: image).imageScale(.medium)
                
            Text(name)
                .font(.system(size: 22, weight: .semibold))
            Spacer()
        }
        .padding(.vertical)
    }
}

//Invalid instructions.
struct InvalidView: View {
    var stringIn : String
    var body: some View {
        HStack {
            Image(systemName: "info.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            Text(stringIn).font(.system(size:14))
        }
    }
}

//Invalid instructions.
struct InfoView: View {
    var stringIn : String
    var body: some View {
        HStack {
            Image(systemName: "info.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
                .foregroundColor(.gray)
            Text(stringIn)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

//Small input text.
struct SmallInput: View {
    let name: String
    let existingText: String
    let iconName: String
    @Binding var stringIn: String
    var valid: Bool
    
    var body: some View {
        VStack {
            HeadingView(name: name, image: iconName)
            TextField(existingText, text: $stringIn)
                .foregroundColor(Color.black)
                .font(.custom("HelveticaNeue", size: 14))
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(valid ? Color.green : Color(.systemGray3), lineWidth: 2)
                )
        }
    }
}

//Large input text.
struct LargeInput: View {
    let name: String
    let iconName: String
    @Binding var stringIn: String
    var valid: Bool
    
    var body: some View {
        HeadingView(name: name, image: iconName)
        TextEditor(text:  $stringIn)
            .foregroundColor(Color.black)
            .font(.custom("HelveticaNeue", size: 14))
            .padding()
            .lineSpacing(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(valid ? Color.green : Color(.systemGray3), lineWidth: 2)
            )
            .frame(height: 100)
        
    }
}
