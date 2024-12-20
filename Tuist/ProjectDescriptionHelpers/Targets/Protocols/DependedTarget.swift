//
//  DependedTarget.swift
//  ProjectDescriptionHelpers
//
//  Created by Gleb Kovalenko on 11.07.2024.
//

// MARK: - DependedTarget

public protocol DependedTarget {
    
    /// Spm target dependecies
    var spms: [SPMPackagesDependency] { get }
    
    /// Frameworks target dependecies
    var frameworks: [FrameworkDependency] { get }
    
    /// Libaries target dependecies
    var libraries: [LibraryDependecy] { get }
    
    /// SDK target dependecies
    var sdks: [SDKDependency] { get }
    
    /// XCFramerworks target dependecies
    var xcframeworks: [XCFrameworkDependency] { get }
}

// MARK: - Default

extension DependedTarget {
    
    /// Spm target dependecies
    public var spms: [SPMPackagesDependency] {
        []
    }
    
    /// Frameworks target dependecies
    public var frameworks: [FrameworkDependency] {
        []
    }
    
    /// Libaries target dependecies
    public var libraries: [LibraryDependecy] {
        []
    }
    
    /// SDK target dependecies
    public var sdks: [SDKDependency] {
        []
    }
    
    /// XCFramerworks target dependecies
    public var xcframeworks: [XCFrameworkDependency] {
        []
    }
}
