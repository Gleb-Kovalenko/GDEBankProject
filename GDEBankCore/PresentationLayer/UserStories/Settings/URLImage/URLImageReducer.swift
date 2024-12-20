//
//  URLImageReducer.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 6.08.24.
//

import Foundation
import ComposableArchitecture

// MARK: - Reducer

/// A `URLImage` module reducer
///
/// It's a function that describes how to evolve the current `URLImageState` to the next state given an action.
/// The `URLImageReducer` is also responsible for returning any effects that should be run, such as API requests,
/// which can be done by returning an `Effect` value
///
/// - Note: The thread on which effects output is important. An effect's output is immediately sent
///   back into the store, and `Store` is not thread safe. This means all effects must receive
///   values on the same thread, **and** if the `Store` is being used to drive UI then all output
///   must be on the main thread. You can use the `Publisher` method `receive(on:)` for make the
///   effect output its values on the thread of your choice.
public struct URLImageReducer: Reducer {
    
    // MARK: - Properties
    
    /// SessionStorage instance
   // public let sessionStorage: SessionStorage
    
    /// Current access token
    public var accessToken: String? {
        "Chto"
        //sessionStorage.session()?.accessToken
    }
    
    // MARK: - Reducer
    
    public var body: some Reducer<URLImageState, URLImageAction> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                break
                //state.accessToken = environment.accessToken
            case .imageDataObtained:
                state.isLoaded = true
            }
            return .none
        }
    }
}
