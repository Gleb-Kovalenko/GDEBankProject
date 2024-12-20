//
//  TCAViewController.swift
//  GDEBankCore
//
//  Created by incetro on 7/31/24.
//  Copyright © 2024 Incetro. All rights reserved.
//

import UIKit
import ComposableArchitecture
import Combine

// MARK: - TCAViewController

/// Convenience class for view controllers that are powered by state stores.
open class TCAViewController<Feature: Reducer>: UIViewController
where Feature.State: Equatable, Feature.Action: Equatable {
    
    // MARK: Properties
    
    /// The store powering the view controller
    public let store: StoreOf<Feature>
    
    /// True when store observing allowed
    private let isObservingEnabled: Bool = true
    
    /// Cancellable
    private var cancellable: AnyCancellable?
    
    // MARK: Initialization
    
    /// Creates a new store view controller with the given store
    ///
    /// - Parameter store: The store to use with the view controller
    ///
    /// - Returns: A new view controller.
    public init(store: StoreOf<Feature>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
        cancellable = NotificationCenter
            .default
            .publisher(for: NSLocale.currentLocaleDidChangeNotification)
            .sink { [weak self] _ in
                self?.currentLocaleDidChange()
            }
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    deinit {
        cancellable?.cancel()
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
    
    // MARK: - Observing
    
    open func currentLocaleDidChange() {
        removeAllSubviews()
        layout()
        observe(store: store)
    }
    
    // MARK: - Layout
    
    open func layout() {
        
    }
    
    // MARK: - TCA
    
    open func observe(store: StoreOf<Feature>) {
    }
}
