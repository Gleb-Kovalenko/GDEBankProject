//
//  PayTransferIntro.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import ComposableArchitecture

// MARK: - PayTransferIntro

@Reducer
public struct PayTransferIntro {

    // MARK: - Aliases

    public typealias State  = PayTransferIntroState
    public typealias Action = PayTransferIntroAction
    
    // MARK: - Feature
    
    public var body: some Reducer<State, Action> {
        EmptyReducer()
    }
}
