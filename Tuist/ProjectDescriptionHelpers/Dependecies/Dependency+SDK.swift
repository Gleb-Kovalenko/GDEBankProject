//
//  Dependency+SDK.swift
//  ProjectDescriptionHelpers
//
//  Created by Gleb Kovalenko on 21.05.2024.
//

import ProjectDescription

// MARK: - SDKDependency

public enum SDKDependency: CaseIterable {
    
    // MARK: - Cases
    
    /// Frameworks
    case coreLocation
    
    /// Libraries
    /// Empty
    
    // MARK: - Useful
    
    public var name: String {
        switch self {
        case .coreLocation: "CoreLocation"
        }
    }
    
    public var type: SDKType {
        switch self {
        default: .framework
        }
    }
    
    public var status: SDKStatus {
        switch self {
        default: .required
        }
    }
    
    public var platformConditions: PlatformCondition? {
        switch self {
        default: nil
        }
    }
}
