//
//  ForceUpdateState.swift
//  GDEBank
//
//  Created by incetro on 29/05/2022.
//  Copyright © 2022 Incetro Inc. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - ForceUpdateState

/// `ForceUpdate` module state
///
/// Basically, `ForceUpdateState` is a type that describes the data
/// `ForceUpdate` feature needs to perform its logic and render its UI.
public struct ForceUpdateState: Equatable, Codable {

    // MARK: - Properties
    
    /// True if update is soft and false if it's forced
    public let isSoft: Bool

    /// Current block sheet title
    public var title: LocalizedStringKey {
        isSoft ? "New version is available" : "Please, update GDEBank"
    }

    /// Current block sheet description
    public var description: LocalizedStringKey {
        isSoft ? "Update GDEBank to enjoy new features and features." : "The current version of the app is no longer supported. Continue using GDEBank by installing the latest version from the App Store."
    }

    /// Current block sheet button title
    public var buttonTitle: String {
        "Update GDEBank"
    }
}
