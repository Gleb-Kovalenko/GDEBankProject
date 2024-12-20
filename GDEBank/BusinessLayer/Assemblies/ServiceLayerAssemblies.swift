//
//  ServiceLayerAssemblies.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 21.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Swinject
import Foundation
import HTTPTransport
import GDEBankCore

// MARK: - ServiceLayerAssembly

final class ServiceLayerAssembly: CollectableAssembly {

    required init() {
    }

    func assemble(inContainer container: Container) {
        
        container.register(GDEBankService.self) { resolver in
            let transport = resolver.resolve(HTTPTransport.self).unsafelyUnwrapped
            if AppConstants.Business.useMock {
                return GDEBankServiceMockImplementation()
            } else {
                return GDEBankServiceImplementation(transport: transport)
            }
        }.inObjectScope(.container)
    }
}
