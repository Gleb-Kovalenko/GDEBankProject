//
//  Skeletonable.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 14.08.2024.
//

import Foundation
import SwiftUI

// MARK: - Skeletonable

public protocol Skeletonable {
    
    // MARK: - AssociatedType
    
    associatedtype SkeletonBody: View
    
    // MARK: - Properties
    
    static var skeletonBody: SkeletonBody { get }
}

// MARK: - Useful

extension Skeletonable {
    
    public static func skeleton() -> SkeletonBody {
        skeletonBody
    }
}
