//
//  TransactionTypeModelObject.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 10.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import SDAO

// MARK: - TransactionTypeModelObject

public final class TransactionTypeModelObject: RealmModel {
    
    @objc dynamic public var type: String?
    @objc dynamic public var imageURL: String?
}
