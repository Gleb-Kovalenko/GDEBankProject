//
//  Dependency+SPMPackages.swift
//  ProjectDescriptionHelpers
//
//  Created by Gleb Kovalenko on 13.05.2024.
//

import ProjectDescription

// MARK: - SPMPackagesDependency

public enum SPMPackagesDependency: CaseIterable {
    
    // MARK: - Remote
    
    case serviceCore
    case httpTransport
    case kingfisher
    case codex
    case skeletonUI
    case lottie
    case tcaNetworkReducers
    case tca
    case swiftyJSON
    case cache
    case alamofire
    case swiftMarkdownUI
    case activeLabel
    case layout
    case then
    case dao
    case toast
    case pulse
    case toCropViewController
    case swinject
    case deviceKit
    case inputMask
    case hapticFeedback
    case uiKitActions
    case transitionHandler
    case fsCalendar
    case googleSignIn
    case collectionViewPagingLayout
    case sumSub
    case swiftMacrosKit
    case firebase
    case intercom
    
    // MARK: - Local
    
    /// Empty
    
    // MARK: - Useful
    
    public var name: String {
        switch self {
        
        /// Remote
        case .serviceCore: return "ServiceCore"
        case .httpTransport: return "HTTPTransport"
        case .kingfisher: return "Kingfisher"
        case .codex: return "Codex"
        case .skeletonUI: return "SkeletonUI"
        case .lottie: return "Lottie"
        case .tcaNetworkReducers: return "TCANetworkReducers"
        case .tca: return "ComposableArchitecture"
        case .swiftyJSON: return "SwiftyJSON"
        case .cache: return "Cache"
        case .alamofire: return "Alamofire"
        case .swiftMarkdownUI: return "MarkdownUI"
        case .activeLabel: return "ActiveLabel"
        case .layout: return "Layout"
        case .then: return "Then"
        case .dao: return "SDAO"
        case .toast: return "Toast"
        case .pulse: return "Pulse"
        case .toCropViewController: return "CropViewController"
        case .swinject: return "Swinject"
        case .deviceKit: return "DeviceKit"
        case .inputMask: return "InputMask"
        case .hapticFeedback: return "HapticFeedback"
        case .uiKitActions: return "UIKitActions"
        case .transitionHandler: return "TransitionHandler"
        case .fsCalendar: return "FSCalendar"
        case .googleSignIn: return "GoogleSignIn"
        case .collectionViewPagingLayout: return "CollectionViewPagingLayout"
        case .sumSub: return "IdensicMobileSDK"
        case .swiftMacrosKit: return "SwiftMacrosKit"
        case .firebase: return "Firebase"
        case .intercom: return "Intercom"
            
        /// Local
        }
    }
    
    /// Project package
    public var projectPackage: Package {
        switch self {
            
        /// Local
        // case .someCase:
        //    .local(path: ProjectDependencies.pathTo(dependency: name))
            
        /// Remote
        case .serviceCore:
            .remote(
                url: "https://github.com/Incetro/service-core",
                requirement: .branch("main")
            )
        case .httpTransport:
            .remote(
                url: "https://github.com/Incetro/http-transport.git",
                requirement: .branch("fix/error_response")
            )
        case .kingfisher:
            .remote(
                url: "https://github.com/onevcat/Kingfisher",
                requirement: .upToNextMajor(from: "7.10.0")
            )
        case .codex:
            .remote(
                url: "https://github.com/Incetro/codex.git",
                requirement: .branch("master")
            )
        case .skeletonUI:
            .remote(
                url: "https://github.com/CSolanaM/SkeletonUI.git",
                requirement: .upToNextMajor(from: "2.0.0")
            )
        case .lottie:
            .remote(
                url: "https://github.com/airbnb/lottie-ios.git",
                requirement: .upToNextMajor(from: "4.3.3")
            )
        case .tcaNetworkReducers:
            .remote(
                url: "https://github.com/Incetro/tca-network-reducers.git",

                requirement: .branch("develop")
            )
        case .tca:
            .remote(
                url: "https://github.com/Incetro/TCA",
                requirement: .branch("main")
            )
        case .swiftyJSON:
            .remote(
                url: "https://github.com/SwiftyJSON/SwiftyJSON.git",
                requirement: .upToNextMajor(from: "5.0.1")
            )
        case .cache:
            .remote(
                url: "https://github.com/hyperoslo/Cache.git",
                requirement: .upToNextMajor(from: "7.1.0")
            )
        case .alamofire:
            .remote(
                url: "https://github.com/Alamofire/Alamofire.git",
                requirement: .upToNextMajor(from: "5.4.3")
            )
        case .swiftMarkdownUI:
            .remote(
                url: "https://github.com/gonzalezreal/swift-markdown-ui.git",
                requirement: .upToNextMajor(from: "2.3.0")
            )
        case .activeLabel:
            .remote(
                url: "https://github.com/Incetro/ActiveLabel.swift.git",
                requirement: .upToNextMajor(from: "1.1.5")
            )
        case .layout:
            .remote(
                url: "https://github.com/Incetro/layout.git",
                requirement: .branch("main")
            )
        case .then:
            .remote(
                url: "https://github.com/Incetro/Then.git",
                requirement: .branch("main")
            )
        case .dao:
            .remote(
                url: "https://github.com/Incetro/DAO.git",
                requirement: .branch("master")
            )
        case .toast:
            .remote(
                url: "https://github.com/Incetro/toast.git",
                requirement: .branch("main")
            )
        case .pulse:
            .remote(
                url: "https://github.com/kean/Pulse.git",
                requirement: .branch("main")
            )
        case .toCropViewController:
            .remote(
                url: "https://github.com/TimOliver/TOCropViewController.git",
                requirement: .branch("main")
            )
        case .swinject:
            .remote(
                url: "https://github.com/Swinject/Swinject.git",
                requirement: .upToNextMajor(from: "2.8.4")
            )
        case .deviceKit:
            .remote(
                url: "https://github.com/devicekit/DeviceKit.git",
                requirement: .upToNextMajor(from: "5.1.0")
            )
        case .inputMask:
            .remote(
                url: "https://github.com/RedMadRobot/input-mask-ios",
                requirement: .upToNextMajor(from: "7.3.2")
            )
        case .hapticFeedback:
            .remote(
                url: "https://github.com/Incetro/haptic-feedback",
                requirement: .branch("main")
            )
        case .uiKitActions:
            .remote(
                url: "https://github.com/Incetro/uikit-actions",
                requirement: .branch("main")
            )
        case .transitionHandler:
            .remote(
                url: "https://github.com/Incetro/transition-handler",
                requirement: .branch("feature/seamless_version")
            )
        case .fsCalendar:
            .remote(
                url: "https://github.com/WenchaoD/FSCalendar",
                requirement: .upToNextMajor(from: "2.8.4")
            )
        case .googleSignIn:
            .remote(
                url: "https://github.com/google/GoogleSignIn-iOS",
                requirement: .upToNextMajor(from: "8.0.0")
            )
        case .collectionViewPagingLayout:
            .remote(
                url: "https://github.com/Incetro/CollectionViewPagingLayout.git",
                requirement: .branch("master")
            )
        case .sumSub:
            .remote(
                url: "https://github.com/SumSubstance/IdensicMobileSDK-iOS",
                requirement: .upToNextMajor(from: "1.32.0")
            )
        case .swiftMacrosKit:
            .remote(
                url: "https://github.com/Incetro/SwiftMacrosKit.git",
                requirement: .branch("main")
            )
        case .firebase:
            .remote(
                url: "https://github.com/firebase/firebase-ios-sdk.git",
                requirement: .upToNextMajor(from: "11.4.0")
            )
        case .intercom:
            .remote(
                url: "https://github.com/intercom/intercom-ios-sp",
                requirement: .upToNextMajor(from: "18.2.0")
            )
        }
    }
    
    public var subModules: [String]? {
        switch self {
        case .pulse: ["Pulse", "PulseUI"]
        case .firebase: ["FirebaseCore", "FirebaseMessaging"]
        default: nil
        }
    }
    
    public var platformConditions: PlatformCondition? {
        return nil
    }
}
