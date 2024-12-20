//
//  SelectableButtonState.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.08.2024.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//

import ComposableArchitecture
import Foundation

// MARK: - SelectableButtonState

@ObservableState
@dynamicMemberLookup
public struct SelectableButtonState<ChildObject: Equatable & Identifiable>: Identifiable, Equatable {
    
    // MARK: - Mode
    
    public enum Mode: Equatable {
        
        // MARK: - Cases
        
        case radioButton
        case checkbox
    }
    
    // MARK: - Properties
    
    /// State id
    public var id: ChildObject.ID {
        childObject.id
    }
    
    /// Button mode
    public let mode: Mode
    
    /// Indicates is button selected
    public var isSelected = false
    
    /// Indicates is button can be unchecked by self
    public var uncheckedAllowed = false
    
    /// Child state of the checkbox item
    public let childObject: ChildObject
}

// MARK: - DynamicMemberLookup

extension SelectableButtonState {
    
    public subscript<Dependency>(dynamicMember keyPath: KeyPath<ChildObject, Dependency>) -> Dependency {
        childObject[keyPath: keyPath]
    }
}

// MARK: - Initializers

extension SelectableButtonState {
    
    public init(
        mode: Mode,
        isSelected: Bool = false,
        uncheckedAllowed: Bool = false,
        childObject: ChildObject
    ) {
        self.mode = mode
        self.uncheckedAllowed = uncheckedAllowed
        self.isSelected = isSelected
        self.childObject = childObject
    }
    
    public init(
        mode: Mode,
        isSelected: Bool = false,
        uncheckedAllowed: Bool = false,
        childObject: String
    ) where ChildObject == IdentifiableString {
        self.mode = mode
        self.isSelected = isSelected
        self.uncheckedAllowed = uncheckedAllowed
        self.childObject = childObject.toIdentifiable
    }
}
