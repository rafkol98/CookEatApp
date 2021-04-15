//
//  EditProfileView.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 16/04/2021.
//

import SwiftUI

struct EditProfileView: View {
    @State var name: String = ""
    
    @State var addImage = false
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    @State var added = false
    
    
    var body: some View {
        VStack {
            HStack(alignment: .top ){
                 Button(action: { addImage.toggle() }, label: {
                    ZStack {
                        if let image = image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .cornerRadius(60)
                                .padding()
                            
                        } else {
                            Image("add_photo")
                                .resizable()
                                //Rendering mode allows us to add a colour to the image.
                                .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .padding()
                                .foregroundColor(.red)
                        }
                        
                    }
                    
                }).sheet(isPresented: $addImage, onDismiss: loadImage, content: {
                    ImagePicker(image: $selectedUIImage)
                })
            }
            
            
            SmallInput(name: "Username", iconName: "textformat", stringIn: $name, valid: Color.gray)
            
           Spacer()
            
//            Button(action: {
//
//            }, label: {
//               CustomButton(name: "Edit Profile")
//            })
        }
        .padding()
    }
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else {return}
        image = Image(uiImage: selectedImage)
    }
}



struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
