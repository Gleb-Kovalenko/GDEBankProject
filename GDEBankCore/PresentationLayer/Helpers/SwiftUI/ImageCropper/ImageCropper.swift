//
//  ImageCropper.swift
//  GDEBank
//
//  Created by incetro on 01.08.2024.
//

import UIKit
import Foundation
import SwiftUI
import CropViewController

// MARK: - ImageCropper

public struct ImageCropper: UIViewControllerRepresentable {

    // MARK: - Properties

    /// Temp url of image to crop
    public var imageTempURL: URL?
    
    /// Image path
    public let imagePath: String
    
    /// Crop style
    let cropStyle: CropViewCroppingStyle
    
    /// Preset aspect ratio
    let aspectRatioPreset: CropViewControllerAspectRatioPreset

    /// Block that calls when image crops
    let croppedImageURL: (URL?) -> Void

    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Initializers
    
    public init(
        imageTempURL: URL? = nil,
        imagePath: String,
        cropStyle: CropViewCroppingStyle,
        aspectRatioPreset: CropViewControllerAspectRatioPreset,
        croppedImageURL: @escaping (URL?) -> Void
    ) {
        self.imageTempURL = imageTempURL
        self.imagePath = imagePath
        self.cropStyle = cropStyle
        self.aspectRatioPreset = aspectRatioPreset
        self.croppedImageURL = croppedImageURL
    }

    // MARK: - Coordinator

    public class Coordinator: NSObject, CropViewControllerDelegate {
        var parent: ImageCropper

        init(_ parent: ImageCropper) {
            self.parent = parent
        }

        public func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
            parent.croppedImageURL(image.saveAndExtractImageURL(with: parent.imagePath))
            dismiss(cropViewController: cropViewController)
        }

        public func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
            parent.croppedImageURL(image.saveAndExtractImageURL(with: parent.imagePath))
            dismiss(cropViewController: cropViewController)
        }

        private func dismiss(cropViewController: CropViewController) {
            cropViewController.children.first?.modalTransitionStyle = .coverVertical
            cropViewController.children.first?.presentingViewController?.dismiss(animated: true)
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func makeUIViewController(context: Context) -> CropViewController {
        guard let fileURL = imageTempURL,
              let data = try? Data(contentsOf: fileURL),
              let image = UIImage(data: data)
        else {
            return CropViewController(croppingStyle: cropStyle, image: .init(named: "error-cicle").unsafelyUnwrapped)
        }
        let cropController = CropViewController(croppingStyle: cropStyle, image: image)
        cropController.aspectRatioPreset = aspectRatioPreset
        cropController.delegate = context.coordinator
//        cropController.doneButtonColor = .black
//        cropController.cancelButtonColor = .black
        return cropController
    }

    public func updateUIViewController(_ uiViewController: CropViewController, context: Context) {
    }
}
