//
//  DXRowSubtitle.swift
//  GDEBank
//
//  Created by incetro on 12/10/23.
//

import SwiftUI

// MARK: - DXRowTitle

public struct DXRowSubtitle: View {
    
    public let subtitle: LocalizedStringKey
    
    public init(_ subtitle: LocalizedStringKey) {
        self.subtitle = subtitle
    }

    public var body: some View {
        Text(subtitle)
            .font(.inter(size: 13, weight: .regular))
            .foregroundStyle(Colors.textGray.swiftUIColor)
    }
}
