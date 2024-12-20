//
//  Optional.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 13.08.2024.
//

// MARK: - Optional

extension Optional {
    
    public func unwrap<T>(as type: T.Type, _ hint: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line) -> T {
        guard let unwrapped = self as? T else {
            var message = "Cannot convert value to type '\(T.self)'"
            if let hint = hint() {
                message.append(". Debugging hint: \(hint)")
            }
            preconditionFailure(message)
        }
        return unwrapped
    }
    
    public func unwrap<T>(as type: T.Type, _ error: @autoclosure () -> Error, file: StaticString = #file, line: UInt = #line) -> T {
        guard let unwrapped = self as? T else {
            var message = "Cannot convert value to type '\(T.self)'"
            message.append(". Debugging hint: \(error().localizedDescription)")
            preconditionFailure(message)
        }
        return unwrapped
    }
}
