//
//  ImagePicker.swift
//  CookEat
//
//  Created by Rafael Kollyfas on 11/03/2021.
//
//  Image picker allowing the user to choose an image.

import SwiftUI


struct ImagePicker: UIViewControllerRepresentable {
    // UI kit image.
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var mode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        //delegate property executing the imagePickerController method.
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}

//  Pick an image.
extension ImagePicker {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        //Do something with the selected image.
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else {return}
            parent.image = image
            parent.mode.wrappedValue.dismiss()
        }
    }
}
