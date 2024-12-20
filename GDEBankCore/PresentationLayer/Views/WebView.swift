//
//  WebView.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 14.08.2024.
//

import SwiftUI
import WebKit
import Combine

// MARK: - WebViewModel

public class WebViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published public var link: URL
    @Published public var didFinishLoading: Bool = false
    
    // MARK: - Initializers
    
    public init(link: URL) {
        self.link = link
    }
}

// MARK: - WebView

public struct WebView: UIViewRepresentable {
    
   // MARK: - Properties
    
    @ObservedObject public var viewModel: WebViewModel
    
    private let webView = WKWebView()

    // MARK: - Coordinator
    
    public class Coordinator: NSObject, WKNavigationDelegate {
        
        // MARK: - Properties
        
        private var viewModel: WebViewModel
        
        // MARK: - Initializers
        
        public init(_ viewModel: WebViewModel) {
            self.viewModel = viewModel
        }
        
        // MARK: - WKNavigationDelegate
        
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            viewModel.didFinishLoading = true
        }
    }
    
    // MARK: - UIViewRepresentable
    
    public func makeCoordinator() -> WebView.Coordinator {
        Coordinator(viewModel)
    }
    
    public func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: viewModel.link))
        return webView
    }
    
    public func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        webView.navigationDelegate = context.coordinator
    }
}
