//
//  ShareSheet.swift
//  Chibiverse
//
//  Created by Dmitry Savinov on 09.08.2024.
//

import SwiftUI
import ComposableArchitecture

/// A `UIViewControllerRepresentable` that wraps `UIActivityViewController`.
public struct ShareSheet: UIViewControllerRepresentable {
    
    // MARK: - Properties
    
    /// The activity items to share.
    public let activityItems: [Any]
    
    // MARK: - UIViewControllerRepresentable

    /// Creates a new `UIActivityViewController` with the given activity items.
    public func makeUIViewController(context: UIViewControllerRepresentableContext<ShareSheet>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }

    /// This method is called when the `ShareSheet` needs to be updated.
    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ShareSheet>) {
        // We don't need to do anything here because the view controller won't change once it's been created.
    }

    /// The type of view controller to create.
    public typealias UIViewControllerType = UIActivityViewController
}

// MARK: - View

extension View {
    
    /// Displays an alert when then store's state becomes non-`nil`, and dismisses it when it becomes
    /// `nil`.%
    ///
    /// - Parameters:
    ///   - store: A store that describes if the alert is shown or dismissed.
    ///   - dismissal: An action to send when the alert is dismissed through non-user actions, such
    ///     as when an alert is automatically dismissed by the system. Use this action to `nil` out
    ///     the associated alert state.
    @ViewBuilder public func shareSheet<Action>(
        _ store: Store<ShareSheetState<Action>?, Action>,
        dismiss: Action
    ) -> some View {
        self.modifier(
            ShareSheetModifier(
                viewStore: ViewStore(store, observe: { $0 }, removeDuplicates: { $0?.id == $1?.id }),
                dismiss: dismiss
            )
        )
    }
}

// MARK: - ShareSheetModifier

private struct ShareSheetModifier<Action>: ViewModifier {
    
    // MARK: - Properties
    
    /// Share sheet view store
    @ObservedObject var viewStore: ViewStore<ShareSheetState<Action>?, Action>
    
    /// Share sheet dismiss action
    let dismiss: Action
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .sheet(item: viewStore.binding(send: dismiss)) { state in
                ShareSheet(activityItems: state.activityItems)
            }
    }
}
