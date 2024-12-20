//
//  GDEBankAssembliesCollector.swift
//  GDEBank
//
//  Created by incetro on 8/15/24.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Swinject
import GDEBankCore
import Foundation

// MARK: - GDEBankAssembliesCollector

public final class GDEBankAssembliesCollector: AssembliesCollector {
    
    // MARK: - Initializers
    
    public required init() {
    }
    
    // MARK: - AssembliesCollector
    
    public func collect(inContainer container: Container) {
        let assemblies: [CollectableAssembly] = [
            ServiceLayerAssembly(),
            PayBusinessComponents()
        ]
        assemblies.forEach { assembly in
            assembly.assemble(inContainer: container)
        }
    }
}
