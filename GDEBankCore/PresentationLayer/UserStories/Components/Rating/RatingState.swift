//
//  RatingState.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 21.08.2024.
//

import Foundation

// MARK: - RatingState

/// `Rating` module state
///
/// Basically, `RatingState` is a type that describes the data
/// `Rating` feature needs to perform its logic and render its UI.
public struct RatingState: Equatable {
    
    // MARK: - SizeMode
    
    public enum SizeMode {
        
        // MARK: - SizeMode
        
        case large
        case small
        
        // MARK: - Useful
        
        public var size: CGFloat {
            switch self {
            case .large: 32
            case .small: 16
            }
        }
    }
    
    // MARK: - Properties
    
    /// Indicates how much stars is selected (from 0 to 5)
    public var ratingValue = 0
    
    /// View mode
    public let mode: SizeMode
}
