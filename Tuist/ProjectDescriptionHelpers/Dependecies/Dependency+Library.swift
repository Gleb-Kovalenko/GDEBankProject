//
//  Dependency+Library.swift
//  ProjectDescriptionHelpers
//
//  Created by Gleb Kovalenko on 21.05.2024.
//

import ProjectDescription

// MARK: - LibraryDependecy

public enum LibraryDependecy: CaseIterable {
    
    // MARK: - Cases
    
    /// Empty
    
    // MARK: - Useful
    
    public var name: String {
        switch self {
        default: ""
        }
    }
    
    public var headersRoot: Path {
        switch self {
        default: ""
        }
    }
    
    public var path: Path {
        switch self {
        default: ""
        }
    }
    
    public var swiftModuleMap: Path? {
        switch self {
        default: nil
        }
    }
    
    public var platformConditions: PlatformCondition? {
        switch self {
        default: nil
        }
    }
    
    // MARK: - Private
    
    private func lib(name: String) -> String {
        "lib\(name).a"
    }
}
