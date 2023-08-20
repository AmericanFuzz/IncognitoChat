//
//  PhotoPicker.swift
//  FuzzChat
//
//  Created by Teymur Kazakov on 2/1/22.
//

import SwiftUI


struct PhotoPicker: UIViewControllerRepresentable{
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(photoPicker: self)
    }
    
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        
        
    }

    

}
