//
//  Dependency+XCFramework.swift
//  ProjectDescriptionHelpers
//
//  Created by Gleb Kovalenko on 21.05.2024.
//

import ProjectDescription

// MARK: - XCFrameworkDependency

public enum XCFrameworkDependency: CaseIterable {
    
    // MARK: - Cases
    
    /// Empty
    
    // MARK: - Useful
    
    public var name: String {
        switch self {
        default: ""
        }
    }
    
    public var status: FrameworkStatus {
        switch self {
        default: .required
        }
    }
    
    public var path: Path {
        ProjectDependencies.pathTo(dependency: name, frameworkType: .xcframework)
    }
    
    public var platformConditions: PlatformCondition? {
        switch self {
        default: nil
        }
    }
}
