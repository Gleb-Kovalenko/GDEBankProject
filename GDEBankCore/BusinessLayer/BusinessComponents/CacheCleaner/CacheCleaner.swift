//
//  CacheCleaner.swift
//  GDEBank
//
//  Created by incetro on 10/05/2021
//  Copyright © 2021 Incetro Inc. All rights reserved.
//

import Foundation

// MARK: - CacheCleaner

public protocol CacheCleaner {

    /// Clean all cached data
    /// (defaults, realm, disk sotrage, etc.)
    func clean()
}
