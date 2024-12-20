//
//  ProjectDependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by Gleb Kovalenko on 21.05.2024.
//

import ProjectDescription

// MARK: - ProjectDependencies

public enum ProjectDependencies: CaseIterable {
    
    // MARK: - SDK
    
    case sdk
    case spm
    case xcframework
    case framework
    case library
    
    // MARK: - Useful
    
    public static func pathTo(
        dependency name: String,
        frameworkType: FrameworkDependecyType? = nil
    ) -> Path {
        if let frameworkType {
            return "\(Root.dependecies)/\(name).\(frameworkType.format)"
        }
        return "\(Root.dependecies)/\(name)"
    }
    
    /// Target dependency value
    public static func dependencies(for target: DependedTarget) -> [ProjectDescription.TargetDependency] {
        var dependecies = [ProjectDescription.TargetDependency]()
        
        /// Adding sdk
        dependecies += target.sdks.reduce([], { array, sdk in
            array + [.sdk(
                name: sdk.name,
                type: sdk.type,
                status: sdk.status,
                condition: sdk.platformConditions
            )]
        })
        
        /// Adding spm
        dependecies += target.spms.reduce([], { array, package in
            if let subModules = package.subModules {
                return array + subModules.reduce(into: [ProjectDescription.TargetDependency]()) { subModulesDependecies, moduleName in
                    return subModulesDependecies.append(.package(product: moduleName, type: .runtime, condition: package.platformConditions))
                }
            }
            return array + [.package(product: package.name, type: .runtime, condition: package.platformConditions)]
        })
        
        /// Adding xcframeworks
        dependecies += target.xcframeworks.reduce([], { array, xcframework in
            array + [.xcframework(
                path: xcframework.path,
                status: xcframework.status,
                condition: xcframework.platformConditions
            )]
        })
        
        /// Adding frameworks
        dependecies += target.frameworks.reduce([], { array, framework in
            array + [.framework(
                path: framework.path,
                status: framework.status,
                condition: framework.platformConditions
            )]
        })
        
        /// Adding libraries
        dependecies += target.libraries.reduce([], { array, library in
            array + [.library(
                path: library.path,
                publicHeaders: library.headersRoot,
                swiftModuleMap: library.swiftModuleMap,
                condition: library.platformConditions
            )]
        })
        return dependecies
    }
}
