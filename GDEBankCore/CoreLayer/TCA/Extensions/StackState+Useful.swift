//
//  StackState+Useful.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 08.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import ComposableArchitecture

// MARK: - SearchDirection

public enum SearchDirection {
    
    // MARK: - Cases
    
    case fromFirst
    case fromLast
}

// MARK: - StackState+Useful

extension StackState where Element: CasePathable {
    
    // MARK: - First
    
    public func firstID<Case>(for path: CaseKeyPath<Element, Case>) -> StackElementID? {
        id(for: path, from: .fromFirst)
    }
    
    public func firstState<Case>(for path: CaseKeyPath<Element, Case>) -> Case? {
        state(for: path, from: .fromFirst)
    }
    
    public func firstItem<Case>(for path: CaseKeyPath<Element, Case>) -> (id: StackElementID, state: Case)? {
        item(for: path, from: .fromFirst)
    }
    
    // MARK: - Last
    
    public func lastID<Case>(for path: CaseKeyPath<Element, Case>) -> StackElementID? {
        id(for: path, from: .fromLast)
    }
    
    public func lastState<Case>(for path: CaseKeyPath<Element, Case>) -> Case? {
        state(for: path, from: .fromLast)
    }
    
    public func lastItem<Case>(for path: CaseKeyPath<Element, Case>) -> (id: StackElementID, state: Case)? {
        item(for: path, from: .fromLast)
    }
    
    // MARK: - Private
    
    private func id<Case>(for path: CaseKeyPath<Element, Case>, from direction: SearchDirection) -> StackElementID? {
        switch direction {
        case .fromFirst:
            return ids.first(where: { self[id: $0, case: path] != nil })
        case .fromLast:
            return ids.last(where: { self[id: $0, case: path] != nil })
        }
    }
    
    private func item<Case>(for path: CaseKeyPath<Element, Case>, from direction: SearchDirection) -> (id: StackElementID, state: Case)? {
        guard let id = id(for: path, from: direction),
                let state = self[id: id, case: path] else {
            return nil
        }
        return (id: id, state: state)
    }
    
    private func state<Case>(for path: CaseKeyPath<Element, Case>, from direction: SearchDirection) -> Case? {
        item(for: path, from: direction)?.state
    }
}
