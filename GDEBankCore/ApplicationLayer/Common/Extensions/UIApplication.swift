//
//  UIApplication.swift
//  GDEBank
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 incetro. All rights reserved.
//

import UIKit

// MARK: - UIApplication

extension UIApplication {

    public func topViewController(base: UIViewController?) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        } else if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }

    public func topViewController() -> UIViewController? {
        topViewController(base: keyWindow?.rootViewController)
    }
    
    public static func openSettings() {
        guard let url = URL(string: openSettingsURLString) else {
            return
        }
        if shared.canOpenURL(url) {
            shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    public static func openURL(url: URL) {
        if shared.canOpenURL(url) {
            shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    public static func process(route: URLSchemesRouteType) {
        if let url = route.buildURL(), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else if let itunesUrl = URL(string: "itms-apps://itunes.apple.com/app/\(route.type.appStoreID)"), UIApplication.shared.canOpenURL(itunesUrl) {
            UIApplication.shared.open(itunesUrl, options: [:], completionHandler: nil)
        }
    }
    
    public var currentWindow: UIWindow? {
        UIApplication
            .shared
            .connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?
            .windows
            .first { $0.isKeyWindow }
    }

}
