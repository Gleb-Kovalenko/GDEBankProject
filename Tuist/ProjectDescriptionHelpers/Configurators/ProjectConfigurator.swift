//
//  ProjectConfigurator.swift
//  ProjectDescriptionHelpers
//
//  Created by Gleb Kovalenko on 23.05.2024.
//

import ProjectDescription

// MARK: - ProjectConfigurator

public class ProjectConfigurator {
    
    // MARK: - Properties
    
    /// Project organization name
    static let organizationName = "GDEBank"
    
    /// Project packages dependecies
    static let packages = SPMPackagesDependency.allCases.map(\.projectPackage)
    
    /// Project resource synthesizers
    static let resourceSynthesizers = CustomResourceSynthesizer.allCases.map(\.synthesizer)
    
    /// Project base settings
    static let baseSettings: Dictionary<String, SettingValue> = [
        "SDKROOT": "iphoneos",
        "SUPPORTED_PLATFORMS": "iphonesimulator iphoneos",
        "DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym",
        "ENABLE_USER_SCRIPT_SANDBOXING": false,
        "IPHONEOS_DEPLOYMENT_TARGET": "16.0",
        "SWIFT_VERSION": "5.0",
        "ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS": true,
        "DEVELOPMENT_TEAM": "H6F8KM7F3T",
        "TARGETED_DEVICE_FAMILY": "1",
    ]
    
    /// Project additional setting in debug
    static let debugSettings: Dictionary<String, SettingValue> = [
        "SWIFT_COMPILATION_MODE": "singlefile"
    ]
    
    /// Project additional setting in release
    static let releaseSettings: Dictionary<String, SettingValue> = [
        "SWIFT_COMPILATION_MODE": "wholemodule"
    ]
    
    /// Project settings
    static let settings: Settings = .settings(
        base: baseSettings,
        configurations: [
            .debug(
                name: "Debug",
                settings: debugSettings,
                xcconfig: nil
            ),
            .debug(
                name: "Mock",
                settings: debugSettings,
                xcconfig: nil
            ),
            .release(
                name: "Release",
                settings: releaseSettings,
                xcconfig: nil
            ),
        ]
    )
    
    // MARK: - Project
    
    public static func project(name: String, targets: [Target]) -> Project {
        Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            resourceSynthesizers: []
        )
    }
}
