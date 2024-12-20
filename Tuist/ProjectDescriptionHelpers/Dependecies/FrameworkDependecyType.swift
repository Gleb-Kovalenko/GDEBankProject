//
//  FrameworkDependecyType.swift
//  ProjectDescriptionHelpers
//
//  Created by Gleb Kovalenko on 21.05.2024.
//

// MARK: - FrameworkDependecyType

public enum FrameworkDependecyType {
    
    // MARK: - Cases
    
    case framework
    case xcframework
    
    // MARK: - Format
    
    public var format: String {
        switch self {
        case .framework: "framework"
        case .xcframework: "xcframework"
        }
    }
}
