//
//  ActionListItemState.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import SwiftUI

// MARK: - ActionListItemState

public protocol ActionListItemState: Equatable {

    /// Action row title
    var title: String { get }

    /// Action row image
    var icon: DXImageType { get }

    /// Title accent color
    var titleColor: Color { get }
    
    /// Icon accent color
    var iconColor: Color { get }
}
