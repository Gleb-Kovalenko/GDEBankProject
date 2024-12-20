//
//  PayBusinessComponents.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 29.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Swinject
import Foundation
import HTTPTransport
import GDEBankCore

// MARK: - ServiceLayerAssembly

final class PayBusinessComponents: CollectableAssembly {

    required init() {
    }

    func assemble(inContainer container: Container) {
        
        container.register(Localizer.self) { resolver in
            let defaults = container.resolve(UserDefaults.self).unsafelyUnwrapped
            return LocalizerImplementation(
                defaults: defaults,
                localizationStores: [L10n.self, CoreLocalization.self]
            )
        }
        
        container.register(SessionRetrier.self) { resolver in
            let sessionStorage = resolver.resolve(SessionStorage.self).unsafelyUnwrapped
            return SessionRetrier(
                appType: .gdeBank,
                sessionStorage: sessionStorage,
                transport: HTTPTransport(),
                requestInterceptors: resolver.resolve([HTTPRequestInterceptor].self).unsafelyUnwrapped,
                responseInterceptors: resolver.resolve([HTTPResponseInterceptor].self).unsafelyUnwrapped
            )
        }.inObjectScope(.container)
    }
}
