//
//  AppTargets.swift
//  ProjectDescriptionHelpers
//
//  Created by Gleb Kovalenko on 23.05.2024.
//

import ProjectDescription

// MARK: - AppTargets

public enum AppTargets: CaseIterable {
    
    // MARK: - Cases
    
    case GDEBank
    
    // MARK: - Useful
    
    /// Target name
    public var name: String {
        switch self {
        case .GDEBank: "GDEBank"
        }
    }
    
    /// Root folder name
    public var projectName: String {
        switch self {
        case .GDEBank: "GDEBank"
        }
    }
    
    // MARK: - Target
    
    /// Target instance
    public var target: Target {
        AppTargetConfigurator.target(self)
    }
}

// MARK: - DependedTarget

extension AppTargets: DependedTarget {
    
    /// Spm target dependecies
    public var spms: [SPMPackagesDependency] {
        switch self {
        case .GDEBank: [
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
