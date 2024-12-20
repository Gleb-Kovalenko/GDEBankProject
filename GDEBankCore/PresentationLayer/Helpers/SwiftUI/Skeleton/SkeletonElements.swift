//
//  SkeletonElement.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 14.08.2024.
//

import SwiftUI

// MARK: - SkeletonElement

public typealias SkeletonElement = Text

// MARK: - Initializer

extension SkeletonElement {
    
    public init() {
        self.init("")
    }
}

// MARK: - HorizontalSkeletonElement

public typealias HorizontalSkeletonElement = HStack

// MARK: - Initializer

extension HorizontalSkeletonElement {
    
    public init() where Content == Spacer {
        self.init {
            Spacer(minLength: 0)
        }
    }
}

// MARK: - VerticalSkeletonElement

public typealias VerticalSkeletonElement = VStack

// MARK: - Initializer

extension VerticalSkeletonElement {
    
    public init() where Content == Spacer {
        self.init {
            Spacer(minLength: 0)
        }
    }
}
