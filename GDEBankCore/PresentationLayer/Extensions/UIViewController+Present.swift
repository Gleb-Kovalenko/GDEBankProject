//
//  UIViewController+Present.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 8.08.24.
//

import Foundation
import UIKit
import SwiftUI

// MARK: - ViewControllerHolder

public struct ViewControllerHolder {
    
    // MARK: - Properties
    
    public weak var value: UIViewController?
}

// MARK: - ViewControllerKey

public struct ViewControllerKey: EnvironmentKey {
    
    // MARK: - Default
    
    public static var defaultValue: ViewControllerHolder {
        ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)
    }
}

// MARK: - EnvironmentValues

extension EnvironmentValues {
    
    // MARK: - Properties
    
   public var viewController: UIViewController? {
        get { self[ViewControllerKey.self].value }
        set { self[ViewControllerKey.self].value = newValue }
   }
}

// MARK: - UIViewController

extension UIViewController {
    
    // MARK: - Useful
    
    public func present<Content: View>(
        style: UIModalPresentationStyle = .automatic,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        @ViewBuilder builder: () -> Content
    ) {
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        toPresent.modalPresentationStyle = style
        toPresent.modalTransitionStyle = transitionStyle
        toPresent.rootView = AnyView(
            builder()
                .environment(\.viewController, toPresent)
        )
        present(toPresent, animated: true, completion: nil)
    }
}
