//
//  AppTargetConfigurator.swift
//  ProjectDescriptionHelpers
//
//  Created by Gleb Kovalenko on 23.05.2024.
//

import ProjectDescription

// MARK: - AppTargetConfigurator

public class AppTargetConfigurator {
    
    // MARK: - Properties
    
    /// Debug target config settings
    static var debugConfigSettings: Dictionary<String, SettingValue> {
        [:]
    }
    
    /// Release target config settings
    static var releaseConfigSettings: Dictionary<String, SettingValue> {
        [
            "SWIFT_OPTIMIZATION_LEVEL": "-O"
        ]
    }
    
    /// Default target config settings
    static func configSettings(for target: AppTargets) -> Dictionary<String, SettingValue> {
        [
            "CODE_SIGN_IDENTITY": "Apple Development",
            "DEVELOPMENT_TEAM": "H6F8KM7F3T"
        ]
    }
    
    /// Default target sources
    static func sources(for target: AppTargets) -> SourceFilesList {
        [
            SourceFileGlob.glob(
                .relativeToRoot(Root.applicationPath(rootTargetFolderName: target.projectName)),
                excluding: [
                    "Project.swift"
                ]
            )
        ]
    }
    
    /// Default target resources
    static func resources(for target: AppTargets) -> ResourceFileElements {
        var targetResources = [
            Root.applicationPath(rootTargetFolderName: target.projectName, for: .resources).toResourceFileElement
        ]
        targetResources.append(contentsOf: CoreTargets.allCases.map {
            Root.applicationPath(rootTargetFolderName: $0.name, for: .resources).toResourceFileElement
        })
        return ResourceFileElements.resources(targetResources)
    }
    
    /// Target settings
    static func settings(for target: AppTargets) -> Settings {
        .settings(
            base: ProjectConfigurator.baseSettings,
            configurations: [
                .debug(
                    name: "Debug",
                    settings: configSettings(for: target).merging(debugConfigSettings),
                    xcconfig: .relativeToRoot(
                        Root.applicationPath(
                            rootTargetFolderName: target.projectName,
                            for: .resources,
                            addingAllFilesSuffix: false
                        ) + "/\(Root.enviromentFolderName)/Development.xcconfig"
                    )
                ),
                .debug(
                    name: "Mock",
                    settings: configSettings(for: target).merging(debugConfigSettings),
                    xcconfig: .relativeToRoot(
                        Root.applicationPath(
                            rootTargetFolderName: target.projectName,
                            for: .resources,
                            addingAllFilesSuffix: false
                        ) + "/\(Root.enviromentFolderName)/Mock.xcconfig"
                    )
                ),
                .release(
                    name: "Release",
                    settings: configSettings(for: target).merging(releaseConfigSettings),
                    xcconfig: .relativeToRoot(
                        Root.applicationPath(
                            rootTargetFolderName: target.projectName,
                            for: .resources,
                            addingAllFilesSuffix: false
                        ) + "/\(Root.enviromentFolderName)/Production.xcconfig"
                    )
                ),
            ]
        )
    }
    
    /// Target dependecies
    static func dependecies(for target: AppTargets) -> [TargetDependency] {
        ProjectDependencies.dependencies(for: target) +
        CoreTargets.allCases.map(\.targetDependecy)
    }
    
    static func infoPlist(for target: AppTargets) -> InfoPlist {
        let resourcesFolder = Root.applicationPath(
            rootTargetFolderName: target.projectName,
            for: .resources,
            addingAllFilesSuffix: false
        ) + "/Plists/\(target.name)Info.plist"
        return InfoPlist.file(path: .relativeToRoot(resourcesFolder))
    }
    
    // MARK: - Target
    
    /// Function that create a target
    public static func target(_ target: AppTargets) -> Target {
        .target(
            name: target.name,
            destinations: .iOS,
            product: .app,
            bundleId: "",
            deploymentTargets: .iOS("16.0"),
            infoPlist: infoPlist(for: target),
            sources: sources(for: target),
            resources: resources(for: target),
            entitlements: .file(
                path: .path(
                    Root.applicationPath(
                        rootTargetFolderName: target.projectName,
                        addingAllFilesSuffix: false
                    ) + ".entitlements"
                )
            ),
            scripts: PreScripts.allCases.filter(\.isAvailable).map {
                $0.script(for: target.projectName)
            } ,
            dependencies: dependecies(for: target),
            settings: settings(for: target)
        )
    }
}
