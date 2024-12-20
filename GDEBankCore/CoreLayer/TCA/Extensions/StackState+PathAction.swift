//
//  StackState+PathAction.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 16.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import ComposableArchitecture

// MARK: - StackState+PathAction

extension StackState where Element: CasePathable {
    
    public mutating func process<R: Reducer>(
        _ pathAction: PathAction<R>,
        from child: PartialCaseKeyPath<Element>,
        transformToPath: (R.State) -> Element
    ) {
        switch pathAction {
        case .push(let state):
            append(transformToPath(state))
        case .popTo(let id):
            pop(to: id)
        case .popFrom(let id):
            pop(from: id)
        case .goBack:
            removeLast()
        case .popToAppRoot:
            removeAll()
        case .popToRoot:
            removeAll(after: { $0.is(child) })
        case .none:
            return
        case .removeLast(let count):
            removeLast(count)
        }
    }
}
