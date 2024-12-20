//
//  QuickLookFileView.swift
//  Test
//
//  Created by Gleb Kovalenko on 06.12.2024.
//

import SwiftUI
import Foundation
import QuickLook

// MARK: - QuickLookFileView

public struct QuickLookFileView: UIViewControllerRepresentable {
    
    // MARK: - Properties
    
    /// Local file url to preview
    public let localFileURL: URL
    
    // MARK: - UIViewControllerRepresentable

    public func makeUIViewController(context: Context) -> QLPreviewController {
        let previewController = QLPreviewController()
        previewController.dataSource = context.coordinator
        return previewController
    }

    public func updateUIViewController(_ uiViewController: QLPreviewController, context: Context) {
        
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(localFileURL: localFileURL)
    }
    
    // MARK: - Coordinator

    public class Coordinator: NSObject, QLPreviewControllerDataSource {
        
        // MARK: - Properties
        
        /// Local file url to preview
        public let localFileURL: URL
        
        // MARK: - Initializers

        /// Default initializer
        public init(localFileURL: URL) {
            self.localFileURL = localFileURL
        }
        
        // MARK: - QLPreviewControllerDataSource

        public func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }

        public func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            return localFileURL as QLPreviewItem
        }
    }
}
