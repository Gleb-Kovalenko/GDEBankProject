//
//  PushNotificationServiceImplementation.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 12.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import ServiceCore
import HTTPTransport

// MARK: - PushNotificationServiceImplementation

public final class PushNotificationServiceImplementation: WebService {
}

// MARK: - PushNotificationService

extension PushNotificationServiceImplementation: PushNotificationService {
    
    public func setFirebaseToken(token: String) async throws -> Bool {
        let parameters = self.fillHTTPRequestParameters(
            self.jsonParameters,
            with: [
                "token": token,
                "type": "firebase"
            ]
        )
        let request = HTTPRequest(
            httpMethod: .post,
            endpoint: "profile/firebase/",
            parameters: [parameters],
            timeout: 30,
            base: self.baseRequest
        )
        let status: String = try await asyncCall(from: request, dataByKey: "status")
        return status.asResultBool
    }
}
