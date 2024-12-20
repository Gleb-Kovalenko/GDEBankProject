//
//  Dependency+Framework.swift
//  ProjectDescriptionHelpers
//
//  Created by Gleb Kovalenko on 21.05.2024.
//

import ProjectDescription

// MARK: - FrameworkDependency

public enum FrameworkDependency: CaseIterable {
    
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
        default: .optional
        }
    }
    
    public var path: Path {
        ProjectDependencies.pathTo(dependency: name, frameworkType: .framework)
    }
    
    public var platformConditions: PlatformCondition? {
        switch self {
        default: nil
        }
    }
}
