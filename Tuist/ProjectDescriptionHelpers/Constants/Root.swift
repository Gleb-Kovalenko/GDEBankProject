//
//  Root.swift
//  ProjectDescriptionHelpers
//
//  Created by Gleb Kovalenko on 25.05.2024.
//

import ProjectDescription

// MARK: - Root

public enum Root {
    
    // MARK: - Main
    
    public static let enviromentFolderName = "Environment"
    public static let dependecies = "Dependecies"
    
    // MARK: - Shared
    
    public static let sharedFolderName = "Shared"
    
    // MARK: - AbsolutePath
    
    /// Get application path of layer and adding folder if neccessary
    public static func applicationPath(
        rootTargetFolderName: String,
        for layer: AppLayer? = nil,
        toFolderWith additionalFolderName: String? = nil,
        addingAllFilesSuffix: Bool = true
    ) -> String {
        var path = "\(rootTargetFolderName)"
        let pathSuffix = addingAllFilesSuffix ? "/**" : ""
        if let layer {
            path += "/\(layer.folderName)"
        }
        if let additionalFolderName {
            path += "/\(additionalFolderName)"
        }
        return path + pathSuffix
    }
}
