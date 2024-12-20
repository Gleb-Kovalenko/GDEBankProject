//
//  PayTabView.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.08.2024.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import SwiftMacrosKit

// MARK: - PayTabView

@WithLocalizationUpdater
public struct PayTabView: View {
    
    // MARK: - Properties
    
    /// The store powering the `PayTab` reducer
    @Perception.Bindable public var store: StoreOf<PayTab>
    
    // MARK: - View
    
    public var body: some View {
        WithPerceptionTracking {
            TabView(selection: $store.selectedTab.sending(\.tabButtonTapped)) {
                TabItemView(
                    tab: .main,
                    content: mainView
                )
                TabItemView(
                    tab: .exit,
                    content: exitView
                )
            }
            .accentColor(.accent)
        }
    }
    
    private var mainView: some View {
        MainTabCoordinatorView(
            store: store.scope(
                state: \.mainTabCoordinator,
                action: \.mainTabCoordinator
            )
        )
    }
    
    private var exitView: some View {
        Color.clear
    }
}

// MARK: - TabItemView

private struct TabItemView<Content: View>: View {

    // MARK: - Properties
    
    /// The tab information
    let tab: Tabs
    
    /// The content of the tab
    let content: Content
    
    // MARK: - Initializers
    
    init(tab: Tabs, @ViewBuilder content: () -> Content) {
        self.tab = tab
        self.content = content()
    }
    
    init(tab: Tabs, content: Content) {
        self.tab = tab
        self.content = content
    }

    // MARK: - View
    
    var body: some View {
        content
            .tag(tab)
            .tabItem {
                Image(tab.imageResource)
                    .renderingMode(.template)
                Text(tab.title)
            }
    }
}
