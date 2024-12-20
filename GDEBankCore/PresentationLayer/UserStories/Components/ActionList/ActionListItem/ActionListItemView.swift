//
//  ActionListItemView.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import SwiftUI
import Kingfisher
import ComposableArchitecture
import SwiftMacrosKit

// MARK: - ActionListItemView

@WithLocalizationUpdater
public struct ActionListItemView<Payload: ActionListItemState>: View {
    
    // MARK: - Aliases
    
    public typealias ActionClosure<P> = (P) -> Void
    
    // MARK: - Properties
    
    /// Target Payload value with necessary data
    public let payload: Payload
    
    /// Action that calls on tap
    public let action: ActionClosure<Payload>
    
    // MARK: - Initializers
    
    /// Default initializer
    /// - Parameter payload: Target Payload value with necessary data
    /// - Parameter action: Action that calls on tap
    public init(payload: Payload, action: @escaping ActionClosure<Payload>) {
        self.payload = payload
        self.action = action
    }
    
    // MARK: - View

    public var body: some View {
        Button {
            action(payload)
        } label: {
            HStack(spacing: 16) {
                switch payload.icon {
                case .imageURL(let imageURL):
                    KFImage(imageURL)
                        .resizable()
                        .placeholder { LinearGradient.cgImagePlaceholder }
                        .scaledToFill()
                        .clipped()
                case .assetsImage(let imageString):
                    Image(imageString)
                        .renderingMode(.template)
                        .frame(size: 24)
                        .foregroundStyle(payload.iconColor)
                case .systemImage(let systemImage):
                    Image(systemName: systemImage)
                        .renderingMode(.template)
                        .frame(size: 24)
                        .foregroundStyle(payload.iconColor)
                }
                Text(payload.title)
                    .font(.inter(size: 16, weight: .regular))
                    .foregroundStyle(payload.titleColor)
                Spacer()
            }
            .padding(.horizontal, 24)
        }
    }
}
