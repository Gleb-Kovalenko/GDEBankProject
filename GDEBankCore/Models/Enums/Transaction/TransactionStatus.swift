//
//  TransactionStatus.swift
//  GDEBankWallet
//
//  Created by Gleb Kovalenko on 21.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI

// MARK: - TransactionStatus

public enum TransactionStatus: String, Equatable, CaseIterable {
    
    // MARK: - Cases
    
    case new
    case success
    case pending
    case error
    
    // MARK: - Useful
    
    public var name: String {
        switch self {
        case .new:
            return CoreLocalization.Transaction.Status.New.name
        case .success:
            return CoreLocalization.Transaction.Status.Success.name
        case .pending:
            return CoreLocalization.Transaction.Status.Pending.name
        case .error:
            return CoreLocalization.Transaction.Status.Error.name
        }
    }
    
    public var backgroundColor: Color {
        switch self {
        case .new:
            return CoreColors.warning3.swiftUIColor
        case .success:
            return CoreColors.success3.swiftUIColor
        case .pending:
            return CoreColors.gray5.swiftUIColor
        case .error:
            return CoreColors.alert3.swiftUIColor
        }
    }
    
    public var foregroundColor: Color {
        switch self {
        case .new:
            return CoreColors.warning1.swiftUIColor
        case .success:
            return CoreColors.success1.swiftUIColor
        case .pending:
            return CoreColors.gray1.swiftUIColor
        case .error:
            return CoreColors.alert1.swiftUIColor
        }
    }
    
    public var imageName: String {
        switch self {
        case .new:
            return CoreAssets.addCircle.name
        case .success:
            return CoreAssets.checkCircle.name
        case .pending:
            return CoreAssets.hourglass.name
        case .error:
            return CoreAssets.alertTriangle.name
        }
    }
    
    public var statusImageName: String {
        switch self {
        case .new:
            return CoreAssets.checks.name
        case .success:
            return CoreAssets.checks.name
        case .pending:
            return CoreAssets.checks.name
        case .error:
            return CoreAssets.checks.name
        }
    }
    
    public var statusImageColor: Color {
        switch self {
        case .new:
            return CoreColors.success1.swiftUIColor
        case .success:
            return CoreColors.success1.swiftUIColor
        case .pending:
            return CoreColors.success1.swiftUIColor
        case .error:
            return CoreColors.success1.swiftUIColor
        }
    }
}

// MARK: - Custom Decoding

extension TransactionStatus: Decodable {
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        
        // MARK: - Cases
        
        case status
    }
    
    // MARK: - Initializers
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let statusString = try container.decode(String.self)
        let cleanedStatus = statusString.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let status = TransactionStatus(rawValue: cleanedStatus) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: CoreLocalization.Errors.parseError)
        }
        self = status
    }
}

// MARK: - Randomable

extension TransactionStatus: Randomable {
    
    public static func random() -> Self {
        allCases.randomElement().unsafelyUnwrapped
    }
}
