//
//  ForceUpdateReducer.swift
//  GDEBank
//
//  Created by incetro on 29/05/2022.
//  Copyright © 2022 Incetro Inc. All rights reserved.
//

import ComposableArchitecture
import UIKit

// MARK: - Reducer

public struct ForceUpdateReducer: Reducer {

    // MARK: - Properties
    
    /// UIApplication instance
    public let application: UIApplication

    // MARK: - Reducer
    
    public var body: some Reducer<ForceUpdateState, ForceUpdateAction> {
        Reduce { state, action in
            switch action {
            case .updateButtonTapped:
                guard let url = URL(string: "https://apps.apple.com") else { break }
                application.open(url, options: [:], completionHandler: nil)
            }
            return .none
        }
    }
}

// MARK: - Aliases

/// `Reducer` alias
public typealias ForceUpdateFeature = ForceUpdateReducer

/// `Store` alias
public typealias ForceUpdateStore = Store<ForceUpdateState, ForceUpdateAction>
