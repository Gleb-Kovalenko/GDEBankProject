//
//  VerificationSuccessState.swift
//  GDEBankCore
//
//  Created by Andrey Barsukov on 23.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import ComposableArchitecture

// MARK: - VerificationSuccessState

@ObservableState
public struct VerificationSuccessState: Equatable {
    
    // MARK: - Properties
    
    /// Localization data for the verification success screen.
    public var l10n: VerificationSuccessLocalization
    
    // MARK: - Initializers
    
    /// Initializes a new instance of `VerificationSuccessState`.
    ///
    /// - Parameter l10n: The localization data for the verification success screen.
    public init(
        l10n: VerificationSuccessLocalization
    ) {
        self.l10n = l10n
    }
}

// MARK: - Variations

public extension VerificationSuccessState {
    
    /// A variation of `VerificationSuccessState` for phone verification.
    static var phone: VerificationSuccessState {
        VerificationSuccessState(
            l10n: .phone
        )
    }
    
    /// A variation of `VerificationSuccessState` for email verification.
    static var email: VerificationSuccessState {
        VerificationSuccessState(
            l10n: .email
        )
    }
}

