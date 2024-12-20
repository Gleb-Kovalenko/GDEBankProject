//
//  CoreTargets.swift
//  ProjectDescriptionHelpers
//
//  Created by Gleb Kovalenko on 11.07.2024.
//

import ProjectDescription

// MARK: - CoreTargets

public enum CoreTargets: CaseIterable {
    
    // MARK: - Cases
    
    case GDEBankCore
    
    // MARK: - Useful
    
    /// Target name
    public var name: String {
        switch self {
        case .GDEBankCore: "GDEBankCore"
        }
    }
    
    /// Target bundle id
    public var bundleID: String {
        switch self {
        case .GDEBankCore: "com.GDEBank-core"
        }
    }
    
    // MARK: - Target
    
    /// Target instance
    public var target: Target {
        CoreTargetConfigurator.target(self)
    }
    
    /// Target dependecy
    public var targetDependecy: ProjectDescription.TargetDependency {
        .project(target: name, path: .relativeToRoot("\(name)"), condition: nil)
    }
}

// MARK: - DependedTarget

extension CoreTargets: DependedTarget {
    
    /// Spm target dependecies
    public var spms: [SPMPackagesDependency] {
        switch self {
        case .GDEBankCore: [
            .codex,
            .swinject,
            .alamofire,
            .cache,
            .pulse,
            .tcaNetworkReducers,
            .tca,
            .toCropViewController,
            .dao,
            .serviceCore,
            .layout,
            .activeLabel,
            .skeletonUI,
            .deviceKit,
            .pulse,
            .toast,
            .then,
            .swiftMarkdownUI,
            .kingfisher,
            .hapticFeedback,
            .inputMask,
            .uiKitActions,
            .transitionHandler,
            .fsCalendar,
            .googleSignIn,
            .collectionViewPagingLayout,
            .sumSub,
            .swiftMacrosKit,
            .firebase,
            .intercom
        ]
        }
    }
}
