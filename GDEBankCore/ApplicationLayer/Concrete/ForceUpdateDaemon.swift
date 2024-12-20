//
//  ForceUpdateDaemon.swift
//  GDEBank
//
//  Created by incetro on 10/05/2021
//  Copyright © 2021 incetro. All rights reserved.
//

import ComposableArchitecture
import UIKit
import SwiftUI

// MARK: - ForceUpdateDaemon

public final class ForceUpdateDaemon {

    // MARK: - Properties

    /// Bundle instance
    private let bundle: Bundle
    
    /// UIApplication instance
    private let application: UIApplication = .shared
    
    /// NotificationCenter instance
    private let notificationCenter: NotificationCenter = .default

    // MARK: - Initializers

    /// Default initializer
    ///
    /// - Parameter bundle: Bundle instance
    public init(bundle: Bundle) {
        self.bundle = bundle
    }
    
    private func isUpdateRequired(appVersion: String, minVersion: String) -> Bool {

        /// Regular expression for checking the validity of the version format (major.minor.patch)
        let versionPattern = #"^\d+\.\d+\.\d+$"#
        
        /// Check if both strings match the version format
        if appVersion.range(of: versionPattern, options: .regularExpression) == nil ||
           minVersion.range(of: versionPattern, options: .regularExpression) == nil {
            return false
        }
        
        /// Split version strings into components
        let appComponents = appVersion.components(separatedBy: ".").compactMap { Int($0) }
        let minComponents = minVersion.components(separatedBy: ".").compactMap { Int($0) }
        
        /// Ensure that we have major, minor, and patch versions
        guard appComponents.count == 3 && minComponents.count == 3 else {
            return false
        }
        
        /// Compare version components
        for (app, min) in zip(appComponents, minComponents) {
            if app < min {
                return true
            } else if app > min {
                return false
            }
        }
        
        return false
    }

    private func showForceUpdate(isSoft: Bool) {
        guard let viewController = application.currentWindow?.rootViewController else { return }
        let forceUpdateViewController = UIHostingController(
            rootView: ForceUpdateView(
                store: Store(
                    initialState: ForceUpdateState(isSoft: isSoft),
                    reducer: {
                        ForceUpdateReducer(application: application)
                    }
                )
            )
        )
        forceUpdateViewController.isModalInPresentation = !isSoft
        if #available(iOS 15.0, *) {
            if let presentationController = forceUpdateViewController.presentationController as? UISheetPresentationController, isSoft {
                presentationController.detents = [.medium()]
            }
        }
        viewController.present(forceUpdateViewController, animated: true)
    }
}

// MARK: - Daemon

extension ForceUpdateDaemon: Daemon {

    public func start() {
        notificationCenter.addObserver(forName: .checkUpdate, object: nil, queue: .main) { [self] notification in
            guard let setting = notification.object as? AppVersionInfoPlainObject else { return }
            guard let releaseVersionNumber = self.bundle.releaseVersionNumber else { return }
            if self.isUpdateRequired(appVersion: releaseVersionNumber, minVersion: setting.minVersion) {
                self.showForceUpdate(isSoft: false)
            } else if self.isUpdateRequired(appVersion: releaseVersionNumber, minVersion: setting.currentVersion) {
                self.showForceUpdate(isSoft: true)
            }
        }
    }

    public func stop() {
    }
}
