//
//  ImagePicker.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 8.08.24.
//

import SwiftUI

// MARK: - ImagePicker

public struct ImagePicker: UIViewControllerRepresentable {

    // MARK: - Properties

    @Environment(\.presentationMode)
    private var presentationMode
    
    /// Image path to save selected image
    public let imagePath: String

    /// Block that calls when image picked
    public let selectedImageURL: (URL?) -> Void
    
    // MARK: - Initializers
    
    public init(imagePath: String, selectedImageURL: @escaping (URL?) -> Void) {
        self.imagePath = imagePath
        self.selectedImageURL = selectedImageURL
    }

    // MARK: - UIViewControllerRepresentable

    public func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // MARK: - Coordinator

    public final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        // MARK: - Properties

        /// ImagePicker instance
        public var parent: ImagePicker

        /// Default initializer
        /// - Parameter parent: parent ImagePicker instance
        public init(_ parent: ImagePicker) {
            self.parent = parent
        }

        // MARK: - UIImagePickerControllerDelegate

        public func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImageURL(image.saveAndExtractImageURL(with: parent.imagePath))
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

