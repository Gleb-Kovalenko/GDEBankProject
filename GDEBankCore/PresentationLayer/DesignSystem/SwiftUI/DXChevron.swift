//
//  DXChevron.swift
//  GDEBank
//
//  Created by incetro on 12/10/23.
//

import SwiftUI

// MARK: - DXChevron

public struct DXChevron: View {
    
    // MARK: - Properties
    
    /// Chevron size
    public let size: CGFloat
    
    // MARK: - Initializers
    
    public init(size: CGFloat = 16) {
        self.size = size
    }
    
    // MARK: - View
    
    public var body: some View {
        Image(systemName: "chevron.forward")
            .scaledImage(with: .fit, size: size)
            .foregroundStyle(Colors.gray2.swiftUIColor)
    }
}
