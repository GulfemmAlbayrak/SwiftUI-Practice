//
//  PhotoPicker.swift
//  UsedGames
//
//  Created by Gulfem ALBAYRAK on 7.08.2024.
//

import UIKit
import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var imageStore: ImageStore
    var game: Game
    @Binding var selectedPhoto: UIImage?
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.sourceType = sourceType
        pickerController.delegate = context.coordinator
        return pickerController
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
        var photoPicker: PhotoPicker
        
        init(_ picker: PhotoPicker) {
            self.photoPicker = picker
            super.init()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let selectedPhoto = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
                photoPicker.imageStore.setImage(selectedPhoto, forKey: photoPicker.game.itemKey)
                photoPicker.selectedPhoto = selectedPhoto
                if picker.sourceType == .camera {
                    UIImageWriteToSavedPhotosAlbum(selectedPhoto, self, #selector(image(_:error:contextInfo:)), nil)
                }
                
            } else {
                photoPicker.selectedPhoto = nil
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        @objc func image(_ image: UIImage?, error: Error?, contextInfo: UnsafeRawPointer) {
            
        }
    }
}
