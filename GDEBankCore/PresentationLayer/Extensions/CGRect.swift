//
//  CGRect.swift
//  GDEBankCore
//
//  Created by Dmitry Savinov on 07.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation

// MARK: - CGRect

extension CGRect {
    
    public func offset(x: CGFloat = 0, y: CGFloat = 0) -> CGRect {
        CGRect(
            x: minX + x,
            y: minY + y,
            width: width,
            height: height
        )
    }
}
