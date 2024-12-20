//
//  RatingReducer.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 21.08.2024.
//

import Foundation
import ComposableArchitecture

// MARK: - RatingReducer

/// A `Rating` module reducer
///
/// It's a function that describes how to evolve the current `RatingState` to the next state given an action.
/// The `RatingReducer` is also responsible for returning any effects that should be run, such as API requests,
/// which can be done by returning an `Effect` value
///
/// - Note: The thread on which effects output is important. An effect's output is immediately sent
///   back into the store, and `Store` is not thread safe. This means all effects must receive
///   values on the same thread, **and** if the `Store` is being used to drive UI then all output
///   must be on the main thread. You can use the `Publisher` method `receive(on:)` for make the
///   effect output its values on the thread of your choice.
public struct RatingReducer: Reducer {
    
    // MARK: - Reducer
    
    public var body: some Reducer<RatingState, RatingAction> {
        Reduce { state, action in
            switch action {
            case .ratingTapped(let value):
                state.ratingValue = value
            default:
                break
            }
            return .none
        }
    }
}
