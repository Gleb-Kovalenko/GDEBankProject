//
//  SelectableButtonView.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.08.2024.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import SwiftMacrosKit

// MARK: - SelectableButtonView

@WithLocalizationUpdater
public struct SelectableButtonView<ChildObject: Equatable & Identifiable>: View {
    
    // MARK: - Properties

    /// The store powering the `SelectableButton` reducer
    public let store: StoreOf<SelectableButton<ChildObject>>
    
    // MARK: - Initializers
    
    public init(store: StoreOf<SelectableButton<ChildObject>>) {
        self.store = store
    }
    
    // MARK: - View
    
    public var body: some View {
        WithPerceptionTracking {
            ZStack {
                outerShape
                if store.isSelected {
                    innerShape
                }
            }
            .frame(size: 20)
            .animation(.easeInOut(duration: 0.15), value: store.isSelected)
            .onTapGesture {
                store.send(.onTap)
            }
        }
    }
    
    // MARK: - Subviews
    
    private var outerShape: some View {
        Group {
            if store.mode == .checkbox {
                RoundedRectangle(
                    cornerRadius: 3,
                    style: .continuous
                )
                .stroke(Colors.control1.swiftUIColor, lineWidth: 2)
                .frame(size: 18)
            } else {
                Circle()
                    .stroke(
                        store.isSelected
                        ? Colors.control1.swiftUIColor
                        : Colors.gray2.swiftUIColor,
                        lineWidth: 2
                    )
                    .frame(size: 20)
            }
        }
    }
    
    private var innerShape: some View {
        Group {
            if store.mode == .checkbox {
                ZStack {
                    RoundedRectangle(
                        cornerRadius: 3,
                        style: .continuous
                    )
                    .fill(Colors.control1.swiftUIColor)
                    .frame(size: 18)
                    Image(CoreAssets.checkRounded.name)
                        .scaledImage(
                            with: .fit,
                            width: 10,
                            height: 8
                        )
                }
            } else {
                Circle()
                    .fill(Colors.control1.swiftUIColor)
                    .frame(size: 12)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    SelectableButtonView<IdentifiableString>(
        store: Store(
            initialState: SelectableButtonState(mode: .checkbox, childObject: "Privet"),
            reducer: { SelectableButton() }
        )
    )
}
