//
//  VerificationSuccessLocalization.swift
//  GDEBankCore
//
//  Created by Andrey Barsukov on 23.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import SwiftMacrosKit

// MARK: - VerificationSuccessLocalization

/// Represents the localization details for the verification success screen.
@DynamicStringWrapper
public struct VerificationSuccessLocalization {
    
    // MARK: - Properties

    /// The title displayed on the verification success screen.
    public var title: String
    
    /// The title of the button displayed on the verification success screen.
    public var buttonTitle: String
}


// MARK: - Variations

extension VerificationSuccessLocalization {
    
    /// Localization for the verification success screen when verifying phone.
    public static var phone: VerificationSuccessLocalization {
        VerificationSuccessLocalization(
            title: L10n.VerificationSuccess.Phone.title,
            buttonTitle: L10n.VerificationSuccess.buttonTitle
        )
    }
    
    /// Localization for the verification success screen when verifying email.
    public static var email: VerificationSuccessLocalization {
        VerificationSuccessLocalization(
            title: L10n.VerificationSuccess.Email.title,
            buttonTitle: L10n.VerificationSuccess.buttonTitle
        )
    }
}

