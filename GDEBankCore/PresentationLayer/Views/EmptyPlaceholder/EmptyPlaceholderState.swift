//
//  EmptyPlaceholderState.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.08.2024.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//

import Foundation

// MARK: - EmptyPlaceholderState

/// A structure representing the state of an empty placeholder.
public struct EmptyPlaceholderState: Equatable {
    
    // MARK: - Properties
    
    /// Optional property holding the name of the image associated with the empty placeholder.
    /// It can be `nil` if there is no image.
    public var imageName: String?
    
    /// A key associated with a localized title for the empty placeholder.
    /// The key is used to retrieve the actual localized string.
    public let localizedTitleKey: String
    
    /// A key associated with a localized subtitle for the empty placeholder.
    /// The key is used to retrieve the actual localized string.
    public let localizedSubtitleKey: String
    
    /// Optional property holding a key associated with a localized action button for the
    /// empty placeholder. The key is used to retrieve the actual localized string.
    /// It can be `nil` if there is no action button.
    public var localizedActionButtonKey: String?
    
    // MARK: - Initializers
    
    /// Default public initializer for `EmptyPlaceholderState`.
    ///
    /// - Parameters:
    ///   - imageName: The name of the image associated with the empty placeholder.
    ///   - localizedTitleKey: The key associated with the localized title.
    ///   - localizedSubtitleKey: The key associated with the localized subtitle.
    ///   - localizedActionButtonKey: The key associated with the localized action button.
    public init(
        imageName: String? = nil,
        localizedTitleKey: String,
        localizedSubtitleKey: String,
        localizedActionButtonKey: String? = nil
    ) {
        self.imageName = imageName
        self.localizedTitleKey = localizedTitleKey
        self.localizedSubtitleKey = localizedSubtitleKey
        self.localizedActionButtonKey = localizedActionButtonKey
    }
}

// MARK: - Default

extension EmptyPlaceholderState {
    
    static var general: EmptyPlaceholderState {
        EmptyPlaceholderState(
            localizedTitleKey: "There's nothing here yet",
            localizedSubtitleKey: "We are already working on filling this section with useful data 🩵"
        )
    }
}
