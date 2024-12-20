//
//  GDEBankCoreAssembliesCollector.swift
//  GDEBank
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 Incetro Inc. All rights reserved.
//

import Swinject
import Foundation

// MARK: - GDEBankCoreAssembliesCollector

public final class GDEBankCoreAssembliesCollector: AssembliesCollector {
    
    // MARK: - Initializers

    public required init() {
    }

    // MARK: - AssembliesCollector

    public func collect(inContainer container: Container) {
        let assemblies: [CollectableAssembly] = [
            DaemonsAssembly(),
            InfrastructureAssembly(),
            CoreComponentsAssembly(),
            ServiceLayerAssembly(),
            BusinessComponentsAssembly(),
            TranslatorsAssembly()
        ]
        assemblies.forEach { assembly in
            assembly.assemble(inContainer: container)
        }
    }
}
