//
//  UIKitRepresented.swift
//  GDEBankCore
//
//  Created by incetro on 7/26/24.
//  Copyright © 2024 Incetro. All rights reserved.
//

import UIKit
import SwiftUI

// MARK: - View

public extension View {
    
    func uiView() -> _UIHostingView<Self> {
        _UIHostingView(rootView: self)
    }
    
    func uiViewController() -> UIHostingController<Self> {
        UIHostingController(rootView: self)
    }
}
