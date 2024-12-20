//
//  OrganizationStarItem.swift
//  Reviews
//
//  Created by Dmitry Savinov on 13.08.2024.
//

import SwiftUI
import ComposableArchitecture
import SwiftMacrosKit

// MARK: - RatingView

/// A visual representation of `Rating` module.
/// Here we define the view that displays the feature.
/// It holds onto a `Store<RatingState, RatingAction>` so that it can observe
/// all changes to the state and re-render, and we can send all user actions
/// to the store so that state changes.
@WithLocalizationUpdater
public struct RatingView: View {
    
    // MARK: - Properties
    
    /// `MailClients` module `Store` instance
    public let store: StoreOf<RatingReducer>
    
    /// Button star scales
    @State private var scales = Array(repeating: CGFloat(1), count: 5)
    
    // MARK: - Initializers
    
    /// Default initializer
    /// - Parameters:
    ///   - store: `RatingStore` instance
    public init(store: StoreOf<RatingReducer>) {
        self.store = store
    }
    
    // MARK: - View
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            HStack(spacing: 16) {
                ForEach(1...AppConstants.Review.totalRating, id: \.self) { value in
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(Int(viewStore.ratingValue) < value ? Colors.bg4.swiftUIColor : .accentColor)
                        .frame(size: viewStore.mode.size)
                        .scaleEffect(scales[value - 1])
                        .onTapGesture {
                            viewStore.send(.ratingTapped(value))
                            withAnimation(.easeIn(duration: 0.15)) {
                                scales[value - 1] = LayoutConstants.tappedStarScale
                            }
                            withAnimation(.easeIn(duration: 0.15).delay(0.15)) {
                                scales[value - 1] = 1.0
                            }
                            async(after: 0.45) {
                                viewStore.send(.ratingSetterOnEnded)
                            }
                        }
                        .animation(.spring(response: 0.1 + Double(value) * 0.05), value: viewStore.ratingValue)
                }
            }
            .simultaneousGesture(
                DragGesture()
                    .onChanged { gesture in
                        let currentStarValue = Int((gesture.location.x) / viewStore.mode.size)
                        if (1...5).contains(currentStarValue) && viewStore.ratingValue != currentStarValue {
                            withAnimation(.easeIn(duration: 0.15)) {
                                scales[currentStarValue - 1] = LayoutConstants.tappedStarScale
                            }
                            withAnimation(.easeIn(duration: 0.15).delay(0.15)) {
                                scales[currentStarValue - 1] = 1.0
                            }
                            viewStore.send(.ratingTapped(currentStarValue))
                        } else if currentStarValue == 0 && viewStore.ratingValue != currentStarValue {
                            viewStore.send(.ratingTapped(0))
                        }
                    }
                    .onEnded { _ in
                        viewStore.send(.ratingSetterOnEnded)
                    }
            )
            .centered()
        }
    }
}

// MARK: - LayoutConstants

private enum LayoutConstants {
    
    static var starWidth: CGFloat = 40
    static var tappedStarScale: CGFloat = 1.15
}

// MARK: - Preview

#Preview {
    VStack {
        ForEach(0...1, id: \.self) {_ in
            RatingView(
                store: Store(
                    initialState: RatingState(ratingValue: 3, mode: .small),
                    reducer: {
                        RatingReducer()
                    }
                )
            )
        }
    }
}
