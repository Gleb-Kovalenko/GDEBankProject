//
//  TCANavigationController.swift
//  GDEBankCore
//
//  Created by incetro on 7/31/24.
//  Copyright © 2024 Incetro. All rights reserved.
//

import UIKit
import ComposableArchitecture

// MARK: - TCANavigationController

/// Convenience class for view controllers that are powered by state stores.
open class TCANavigationController<Feature: Reducer>: UINavigationController
where Feature.State: Equatable, Feature.Action: Equatable {
    
    // MARK: Properties
    
    /// The store powering the view controller
    public let store: StoreOf<Feature>

    /// True when store observing allowed
    private let isObservingEnabled: Bool
    
    // MARK: Initialization
    
    /// Creates a new store view controller with the given store
    ///
    /// - Parameter store: The store to use with the view controller
    ///
    /// - Returns: A new view controller.
    public init(store: StoreOf<Feature>, isObservingEnabled: Bool = true) {
        self.store = store
        self.isObservingEnabled = isObservingEnabled
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        if isObservingEnabled {
            observe { [weak self] in
                guard let self else { return }
                self.observe(store: store)
            }
        }
    }
    
    // MARK: - TCA
    
    open func observe(store: StoreOf<Feature>) {
    }
}
