//
//  ServiceLayerAssembly.swift
//  GDEBankCore
//
//  Created by Andrey Barsukov on 26.07.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SDAO
import UIKit
import Pulse
import Swinject
import Foundation
import HTTPTransport

// MARK: - ServiceLayerAssembly

public final class ServiceLayerAssembly: CollectableAssembly {

    public required init() {
    }

    public func assemble(inContainer container: Container) {
        
        container.register(KeychainService.self) { resolver in
            KeychainServiceImplementation()
        }.inObjectScope(.container)
        
        container.register(PushNotificationService.self) { resolver in
            let httpTransport = resolver.resolve(HTTPTransport.self).unsafelyUnwrapped
            return PushNotificationServiceImplementation(transport: httpTransport)
        }.inObjectScope(.container)
        
        container.register(TransactionService.self) { resolver in
            let httpTransport = resolver.resolve(HTTPTransport.self).unsafelyUnwrapped
            if AppConstants.Business.useMock {
                return TransactionServiceMockImplementation()
            } else {
                return TransactionServiceImplementation(
                    baseURL: AppConstants.Network.apiURL,
                    transport: httpTransport
                )
            }
        }.inObjectScope(.container)
        
        container.register(HTTPTransport.self) { resolver in
            let retrier = resolver.resolve(SessionRetrier.self).unsafelyUnwrapped
            URLSessionProxyDelegate.enableAutomaticRegistration()
            return HTTPTransport(
                interceptor: HTTPTransportRetrier(delegate: retrier),
                requestInterceptors: resolver.resolve([HTTPRequestInterceptor].self).unsafelyUnwrapped,
                responseInterceptors: resolver.resolve([HTTPResponseInterceptor].self).unsafelyUnwrapped
            )
        }.inObjectScope(.container)
        
        container.register([HTTPRequestInterceptor].self) { resolver in
            [
                resolver.resolve(AddAccessTokenInterceptor.self).unsafelyUnwrapped,
                resolver.resolve(AddNecessarySlashInterceptor.self).unsafelyUnwrapped,
                resolver.resolve(AddApiKeyTokenInterceptor.self).unsafelyUnwrapped,
                resolver.resolve(AddDeviceDataInterceptor.self).unsafelyUnwrapped,
                resolver.resolve(LogRequestInterceptor.self).unsafelyUnwrapped
            ]
        }.inObjectScope(.container)
        
        container.register([HTTPResponseInterceptor].self) { resolver in
            [
                ClarifyErrorInterceptor(errorMessageKeys: ["extended_desc", "errors", "message", "msg"]),
                resolver.resolve(LogResponseInterceptor.self).unsafelyUnwrapped
            ]
        }.inObjectScope(.container)
        
        container.register(LogRequestInterceptor.self) { resolver in
            LogRequestInterceptor(logLevel: AppConstants.Network.Logging.request)
        }.inObjectScope(.container)
        
        container.register(LogResponseInterceptor.self) { resolver in
            LogResponseInterceptor(logLevel: AppConstants.Network.Logging.response)
        }.inObjectScope(.container)
        
        container.register(AddAccessTokenInterceptor.self) { resolver in
            let sessionStorage = resolver.resolve(SessionStorage.self).unsafelyUnwrapped
            return AddAccessTokenInterceptor(sessionStorage: sessionStorage)
        }.inObjectScope(.container)

        container.register(AddNecessarySlashInterceptor.self) { resolver in
            AddNecessarySlashInterceptor()
        }.inObjectScope(.container)
        
        container.register(AddApiKeyTokenInterceptor.self) { resolver in
            AddApiKeyTokenInterceptor()
        }.inObjectScope(.container)

        container.register(AddDeviceDataInterceptor.self) { resolver in
            let bundle = resolver.resolve(Bundle.self).unsafelyUnwrapped
            let device = resolver.resolve(UIDevice.self).unsafelyUnwrapped
            let defaults = resolver.resolve(UserDefaults.self).unsafelyUnwrapped
            return AddDeviceDataInterceptor(
                bundle: bundle,
                device: device,
                defaults: defaults
            )
        }.inObjectScope(.container)
        
        container.register(TransferService.self) { resolver in
            let httpTransport = resolver.resolve(HTTPTransport.self).unsafelyUnwrapped
            if AppConstants.Business.useMock {
                return TransferServiceMockImplementation()
            } else {
                return TransferServiceImplementation(
                    baseURL: AppConstants.Network.apiURL,
                    transport: httpTransport
                )
            }
        }.inObjectScope(.container)
    }
}
