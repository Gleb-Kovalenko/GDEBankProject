//
//  Stylable.swift
//  GDEBankCore
//
//  Created by Dmitry Savinov on 05.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - Stylable

public protocol Stylable {
    
    // MARK: - Associatedtype
    
    associatedtype Appearance: Default
    
    // MARK: - Properties
    
    var appearance: Appearance { get set }
    
    // MARK: - Methods
    
    func style(with appearance: Appearance)
}
