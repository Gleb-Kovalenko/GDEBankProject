//
//  Localizer.swift
//  TheRun
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 incetro. All rights reserved.
//

import Foundation

// MARK: - Localizer

public protocol Localizer {

    /// Current app language
    var currentLanguage: AppLanguage { get }

    /// Set current language
    ///
    /// - Parameter language: new language
    func setCurrrentLanguage(_ language: AppLanguage)
}
