//
//  UIImage.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 5.08.24.
//

import Foundation
import UIKit

extension UIImage {

    /// Returns a system image with the given name
    /// - Parameter systemName: system image name
    /// - Returns: a system image with the given name
    public static func system(_ systemName: String) -> UIImage {
        UIImage(systemName: systemName).unsafelyUnwrapped
    }
    
    /// Returns a system image with the given name
    /// - Parameter systemName: system image name
    /// - Returns: a system image with the given name
    public static func named(_ name: String) -> UIImage {
        UIImage(named: name).unsafelyUnwrapped
    }
    
    /// Save uimage in temporary directory and return image url
    public func saveAndExtractImageURL(with imagePath: String) -> URL? {
        guard let data = self.jpegData(compressionQuality: 0.99) else {
            return nil
        }
        let tempURL = FileManager.default.temporaryDirectory
        let fileURL = tempURL.appendingPathComponent(imagePath)
        do {
            try data.write(to: fileURL)
        } catch {
            return nil
        }
        return fileURL
    }
}
