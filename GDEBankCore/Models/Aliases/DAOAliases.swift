//
//  Aliases+Storage.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 05.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import SDAO
import Monreau

/// DAO alias for TransactionPlainObject entity
public typealias TransactionDAO = DAO<RealmStorage<TransactionModelObject>, TransactionTranslator>
