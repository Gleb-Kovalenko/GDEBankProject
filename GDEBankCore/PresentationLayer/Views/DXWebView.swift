//
//  DXWebView.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 14.08.2024.
//

import SwiftUI

// MARK: - DXWebView

public struct DXWebView: View {
    
    // MARK: - Properties
    
    /// WebViewModel instance
    @ObservedObject var model: WebViewModel
    
    /// Current presentation mode
    @Environment(\.presentationMode) var presentationMode
    
    /// Navigation title
    public let title: DXRowTitleType
    
    /// Target url for site
    public let url: URL
    
    // MARK: - Initializers
    
    public init(title: String, url: URL) {
        self.title = .regular(title)
        self.url = url
        self.model = WebViewModel(link: url)
    }

    public init(localized: LocalizedStringKey, url: URL) {
        self.title = .localized(localized)
        self.url = url
        self.model = WebViewModel(link: url)
    }
    
    // MARK: - View

    public var body: some View {
        NavigationView {
            ZStack {
                WebView(viewModel: model)
                    .ignoresSafeArea(edges: .bottom)
                    .navigationTitle(navigationBarTitle)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        Button(
                            action: {
                                presentationMode.wrappedValue.dismiss()
                            },
                            label: {
                                Image("close")
                            }
                        )
                }
                if !model.didFinishLoading {
                    LoaderView(appearance: .small)
                }
            }
        }
    }
    
    private var navigationBarTitle: Text {
        switch title {
        case .localized(let localizedStringKey):
            return Text(localizedStringKey)
        case .regular(let string):
            return Text(string)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        Text("")
            .sheet(isPresented: .constant(true)) {
                DXWebView(title: "Test url", url: .random())
            }
    }
}
