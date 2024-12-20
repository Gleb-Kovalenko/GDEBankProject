//
//  ServiceCall.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 14.08.2024.
//

import Foundation
import ServiceCore
import Combine

// MARK: - ServiceCall

extension ServiceCall {
    
    @discardableResult public func mockPublish() -> AnyPublisher<Payload, NSError> {
        self
            .publish()
            .delay(for: AppConstants.Network.requestDelay, scheduler: DispatchQueue.main.eraseToAnyScheduler())
            .eraseToAnyPublisher()
    }
}
