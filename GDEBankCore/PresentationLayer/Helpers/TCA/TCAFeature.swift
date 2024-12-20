//
//  TCAFeature.swift
//  GDEBankCore
//
//  Created by incetro on 7/31/24.
//  Copyright © 2024 Incetro. All rights reserved.
//

import ComposableArchitecture

// MARK: - TCAFeature

public protocol TCAFeature: Reducer where State: Equatable, Action: Equatable {
}
