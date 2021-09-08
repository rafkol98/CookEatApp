//
//  Settings.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 24/03/2021.
//
//  View displaying settings/account tab.

import SwiftUI
import Kingfisher


struct AccountView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    // Get environmentObject of whether user is logged in.
    @EnvironmentObject var viewModel: AuthViewModel
    @State var addImage = false
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    
    // Error alert.
    @State private var showAlert = false
    @State private var errorString: String?
    
    // Convert a ui image into a SwiftUI image.
    func loadImage() {
        guard let selectedImage = selectedUIImage else {return}
        image = Image(uiImage: selectedImage)
        viewModel.updateProfilePicture(profileImage: selectedUIImage!) { (result) in
            switch result {
            case .failure(let error):
                self.errorString = error.localizedDescription
            case .success( _):
                break
            }
            self.showAlert = true
        }
        
    }
    
    var body: some View {
        
        ScrollView{
            // If cant find current user show the error message.
            if viewModel.user == nil {
                AccountErrorView()
            } else {
                VStack {
                    TitleView(text: "Account", iconName: "person.fill")
                    
                    VStack{

                        Button(action: { addImage.toggle() }, label: {
                            ZStack {
                                if let image = image {
                                    image
                                        .resizable()
                                        .circularImg()
                                } else {
                                    KFImage(URL(string: viewModel.user!.profileImageUrl))
                                                                .resizable()
                                                                .circularImg()
                                }
                            }

                        })
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Message") , message: Text(self.errorString ?? "Your profile picture was updated."), dismissButton: .default(Text("OK")) {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            )
                        }
                        .sheet(isPresented: $addImage, onDismiss: loadImage, content: {
                            ImagePicker(image: $selectedUIImage)
                        })
                        
                       InfoView(stringIn: "Tap on the picture to update")

                    }
                    .padding(.bottom)
                    Divider()
                    
                    NavigationLink (
                        destination: UserProfileView(user: viewModel.user!),
                        label: {
                            AccountOption(icon: "person.crop.circle", text: "View Profile")
                        })
                        .accessibilityLabel("Profile")
                    
                    NavigationLink (
                        destination: ContributionsView(user: viewModel.user!),
                        label: {
                            AccountOption(icon: "square.stack.3d.up.fill", text: "Contributions")
                        })
                        .accessibilityLabel("Contributions")
                    
                    NavigationLink (
                        destination: RequestsReceivedView(user: viewModel.user!),
                        label: {
                            AccountOption(icon: "tray.and.arrow.down.fill", text: "Requests Received")
                        })
                        .accessibilityLabel("Requests")
                    
                    
                    Spacer()
                    
                    // Sign out button.
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("Sign Out")
                            .standardButton()
                        
                    })
                    .accessibilityLabel("Sign Out")
                    
                }.foregroundColor(.black)
                
            }
        }
    }
    
}
