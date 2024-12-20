//
//  URLImageState.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 6.08.24.
//

import ComposableArchitecture
import SwiftUI
import Kingfisher

// MARK: - URLImageState

/// `URLImage` module state
///
/// Basically, `URLImageState` is a type that describes the data
/// `URLImage` feature needs to perform its logic and render its UI.
public struct URLImageState: Equatable, Identifiable, Codable {

    // MARK: - Properties

    /// Unique identifier
    public let id: UUID
    
    /// Image url
    public var url: URL?
 
    ///  Name of placeholder image
    public let placeholderImageName: String?

    /// If image is loaded
    public var isLoaded = false

    /// Placeholder image
    public var placeholderImage: SwiftUI.Image {
        Image(systemName: "person.crop.circle")
    }
    
    /// Current user auth token
    public var accessToken: String?

    // MARK: - Initializers

    /// Default initializer
    /// - Parameters:
    ///   - url: target url
    ///   - placeholderImage: placeholder image if needed
    public init(url: URL?, placeholderImageName: String? = nil) {
        self.id = UUID()
        self.url = url
        self.placeholderImageName = placeholderImageName
    }
}
