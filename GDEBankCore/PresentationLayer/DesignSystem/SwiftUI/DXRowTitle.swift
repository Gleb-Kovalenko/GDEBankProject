//
//  DXRowTitle.swift
//  GDEBank
//
//  Created by incetro on 12/10/23.
//

import SwiftUI

// MARK: - DXRowTitle

public struct DXRowTitle: View {
    
    public let title: DXRowTitleType
    
    public init(_ title: LocalizedStringKey) {
        self.title = .localized(title)
    }
    
    public init(_ string: String) {
        self.title = .regular(string)
    }

    public var body: some View {
        title.text
            .font(.inter(size: 17, weight: .semibold))
            .foregroundStyle(Colors.textDefault.swiftUIColor)
    }
}

// MARK: - DXRowTitleType

public enum DXRowTitleType {
    
    case localized(LocalizedStringKey)
    case regular(String)
    
    var text: Text {
        switch self {
        case .localized(let key):
            return Text(key)
        case .regular(let string):
            return Text(string)
        }
    }
}
