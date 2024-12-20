//
//  LanguageReducer.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 5.08.24.
//

import UIKit
import Foundation
import ComposableArchitecture

// MARK: - Reducer

/// A `AboutApp` module reducer
///
/// It's a function that describes how to evolve the current `LanguageState` to the next state given an action.
/// The `LanguageReducer` is also responsible for returning any effects that should be run, such as API requests,
/// which can be done by returning an `Effect` value
///
/// - Note: The thread on which effects output is important. An effect's output is immediately sent
///   back into the store, and `Store` is not thread safe. This means all effects must receive
///   values on the same thread, **and** if the `Store` is being used to drive UI then all output
///   must be on the main thread. You can use the `Publisher` method `receive(on:)` for make the
///   effect output its values on the thread of your choice.
@Reducer
public struct LanguageReducer: Reducer {

    // MARK: - Aliases

    public typealias State  = LanguageState
    public typealias Action = LanguageAction
    
    /// `UISelectionFeedbackGenerator` instance
    private let feedbackGenerator: UISelectionFeedbackGenerator
    
    /// `Localizer` instance
    private let localizer: Localizer
    
    // MARK: - Initializers
    
    /// Default initializer
    /// - Parameters:
    ///   - feedbackGenerator: feed back generator
    ///   - localizer: localizer instance
    public init(
        feedbackGenerator: UISelectionFeedbackGenerator,
        localizer: Localizer
    ) {
        self.feedbackGenerator = feedbackGenerator
        self.localizer = localizer
    }
    
    // MARK: - Reducer

    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .setLanguage(let language):
                state.currentLanguage = language
                feedbackGenerator.selectionChanged()
                localizer.setCurrrentLanguage(language)
            default:
                break
            }
            return .none
        }
    }
}
