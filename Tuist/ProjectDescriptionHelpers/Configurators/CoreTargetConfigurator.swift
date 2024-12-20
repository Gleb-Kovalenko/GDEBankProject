//
//  CoreTargetConfigurator.swift
//  ProjectDescriptionHelpers
//
//  Created by Gleb Kovalenko on 11.07.2024.
//

import ProjectDescription

// MARK: - CoreTargetConfigurator

public class CoreTargetConfigurator {
    
    // MARK: - Properties
    
    /// Debug target config settings
    static func debugConfigSettings(for target: CoreTargets) -> Dictionary<String, SettingValue> {
        [:]
    }
    
    /// Release target config settings
    static func releaseConfigSettings(for target: CoreTargets) -> Dictionary<String, SettingValue> {
        [
            "SWIFT_OPTIMIZATION_LEVEL": "-O"
        ]
    }
    
    /// Default target config settings
    static func configSettings(for target: CoreTargets) -> Dictionary<String, SettingValue> {
        [
            "CODE_SIGN_IDENTITY": "Apple Development",
            "DEVELOPMENT_TEAM": "H6F8KM7F3T"
        ]
    }
    
    /// Default target sources
    static func sources(for target: CoreTargets) -> SourceFilesList {
        switch target {
        case .GDEBankCore:
            [
                SourceFileGlob.glob(
                    .relativeToRoot(Root.applicationPath(rootTargetFolderName: target.name)),
                    excluding: [
                        "Project.swift"
                    ]
                )
            ]
        }
    }
    
    /// Default target resources
    static func resources(for target: CoreTargets) -> ResourceFileElements {
        [
            Root.applicationPath(rootTargetFolderName: target.name, for: .resources).toResourceFileElement
        ]
    }
    
    /// Target settings
    static func settings(for target: CoreTargets) -> Settings {
        .settings(
            base: ProjectConfigurator.baseSettings,
            configurations: [
                .debug(
                    name: "Debug",
                    settings: configSettings(for: target).merging(debugConfigSettings(for: target)),
                    xcconfig: nil
                ),
                .debug(
                    name: "Mock",
                    settings: configSettings(for: target).merging(debugConfigSettings(for: target)),
                    xcconfig: nil
                ),
                .release(
                    name: "Release",
                    settings: configSettings(for: target).merging(releaseConfigSettings(for: target)),
                    xcconfig: nil
                ),
            ]
        )
    }
    
    // MARK: - Target
    
    /// Function that create a target
    public static func target(_ target: CoreTargets) -> Target {
        .target(
            name: target.name,
            destinations: .iOS,
            product: .staticFramework,
            bundleId: target.bundleID,
            deploymentTargets: .iOS("16.0"),
            sources: sources(for: target),
            resources: resources(for: target),
            scripts: PreScripts.allCases.filter(\.isAvailable).map { $0.script(for: target.name) },
            dependencies: ProjectDependencies.dependencies(for: target),
            settings: settings(for: target)
        )
    }
}

