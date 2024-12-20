//
//  InfrastructureAssembly.swift
//  GDEBank
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 Incetro Inc. All rights reserved.
//
// swiftlint:disable unused_closure_parameter

import Swinject
import Foundation
import UIKit
import RealmSwift
import Monreau

// MARK: - InfrastructureAssembly

public final class InfrastructureAssembly: CollectableAssembly {

    public required init() {
    }

    public func assemble(inContainer container: Container) {

        container.register(UserDefaults.self) { resolver in
            .standard
        }

        container.register(FileManager.self) { resolver in
            .default
        }
        
        container.register(UISelectionFeedbackGenerator.self) { resolver in
            UISelectionFeedbackGenerator()
        }
        
        container.register(UINotificationFeedbackGenerator.self) { resolver in
            UINotificationFeedbackGenerator()
        }

        container.register(UIWindow.self) { resolver in
            UIWindow(frame: UIScreen.main.bounds)
        }.inObjectScope(.container)

        container.register(HTTPCookieStorage.self) { resolver in
            .shared
        }

        container.register(URLSession.self) { resolver in
            .shared
        }

        container.register(UIDevice.self) { resolver in
            .current
        }
        
        container.register(UIPasteboard.self) { resolver in
            .general
        }

        container.register(UIApplication.self) { resolver in
            let application = UIApplication.shared
            return application
        }

        container.register(Bundle.self) { resolver in
            .main
        }

        container.register(NotificationCenter.self) { resolver in
            .default
        }

        container.register(Container.self) { resolver in
            AssembliesHolder.container
        }
        
        container.register(Realm.self) { resolver in
            do {
                /// Returns path for the given file name
                ///
                /// - Parameter fileName: some file name
                /// - Returns: URL if path was created successfully
                func pathForFileName(_ fileName: String) -> URL? {
                    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as NSString?
                    guard let realmPath = documentDirectory?.appendingPathComponent(fileName) else {
                        return nil
                    }
                    return URL(string: realmPath)
                }
                let configuration = resolver.resolve(RealmConfiguration.self).unsafelyUnwrapped
                var config = Realm.Configuration.defaultConfiguration
                config.encryptionKey = configuration.encryptionKey
                config.schemaVersion = configuration.databaseVersion
                config.migrationBlock = configuration.migrationBlock
                config.fileURL = pathForFileName(configuration.databaseFileName)
                return try Realm(configuration: config)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        
        container.register(RealmConfiguration.self) { resolver in
            let configuration = RealmConfiguration(
                databaseFileName: "GDEBank.realm",
                databaseVersion: 23,
                migrationBlock: { migration, oldSchemaVersion in
                }
            )
            return configuration
        }.inObjectScope(.container)
    }
}
