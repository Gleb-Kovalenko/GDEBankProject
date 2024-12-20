//
//  Error.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 23.08.2024.
//

import Foundation
import ServiceCore

// MARK: - Error

extension Error {

    public static func new(
        message: String,
        code: Int = -1,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) -> NSError {
        let error = NSError(
            domain: "com.gdeBank.app",
            code: code,
            userInfo: [
                NSLocalizedDescriptionKey: message
            ]
        )
        return error
    }
}

extension NSError {
    
    public var errorMessage: String {
        (responseBodyJSONDictionary?.data(byKey: "msg") as? String ?? localizedDescription).uppercasedFirstLetter()
    }
    
    public var sumSubVerificationToken: String? {
        guard let body = responseBodyJSON as? [String: Any],
              let httpStatusCode = httpStatusCode,
              let token = body[AppConstants.Network.ErrorBodyKeys.verificationToken] as? String,
              httpStatusCode == .forbidden else {
            return nil
        }
        return token
    }
    
    public var diggerFileURLString: URL? {
        guard let url = userInfo[AppConstants.Network.ErrorBodyKeys.theFileHasbeenDownloaded] as? URL else {
            return nil
        }
        return url
    }
}
