//
//  Locale.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 8.08.24.
//

import Foundation

// MARK: - Locale

extension Locale {
 
    static func getCustomLocale(_ languageCode: String?) -> Locale {
        guard let languageCode = languageCode else {
            return .current
        }
        let locale = Locale(identifier: languageCode)
        return locale
    }
}
