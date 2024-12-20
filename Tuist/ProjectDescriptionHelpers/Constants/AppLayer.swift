//
//  AppLayer.swift
//  ProjectDescriptionHelpers
//
//  Created by Gleb Kovalenko on 11.07.2024.
//

// MARK: - Root

public enum AppLayer {
    
    // MARK: - Cases
    
    case resources
    case applicationLayer
    case presentationLayer
    case coreLayer
    case businessLayer
    case models
    
    // MARK: - Useful
    
    public var folderName: String {
        switch self {
        case .resources: "Resources"
        case .applicationLayer: "ApplicationLayer"
        case .presentationLayer: "PresentationLayer"
        case .businessLayer: "BusinessLayer"
        case .coreLayer: "CoreLayer"
        case .models: "Models"
        }
    }
}
