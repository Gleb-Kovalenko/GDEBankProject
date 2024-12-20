//
//  CustomResourceSynthesizer.swift
//  ProjectDescriptionHelpers
//
//  Created by Gleb Kovalenko on 23.05.2024.
//

import ProjectDescription

// MARK: - CustomResourceSynthesizer

public enum CustomResourceSynthesizer: CaseIterable {
    
    // MARK: - Cases
    
    case assets
    case fonts
    case plists
    case strings
    
    // MARK: - Synthesizer
    
    public var synthesizer: ResourceSynthesizer {
        switch self {
        case .assets:
            .custom(name: "CustomAssets", parser: .assets, extensions: ["xcassets"])
        case .fonts:
            .custom(name: "CustomFonts", parser: .fonts, extensions: ["otf", "ttc", "ttf"])
        case .plists:
            .plists()
        case .strings:
            .custom(name: "CustomStrings", parser: .strings, extensions: ["strings", "stringsdict"])
        }
    }
}
