//
//  Sampler.swift
//  GDEBank
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 incetro. All rights reserved.
//

import Foundation

// MARK: - Sampler

public final class Sampler {

    // MARK: - Properties

    /// Delay value
    private let delay: TimeInterval

    /// Current queue instance
    private let queue: DispatchQueue

    /// Executing closure
    private var closure: (() -> Void)?

    /// True if the sampler is in a delaying state
    private var isDelaying = false

    // MARK: - Initializers

    /// Default initializer
    ///
    /// - Parameters:
    ///   - delay: delay value
    ///   - queue: current queue instance
    public init(delay: TimeInterval, queue: DispatchQueue = .main) {
        assert(delay >= 0, "Sampler can't have negative delay")
        self.delay = delay
        self.queue = queue
    }

    // MARK: - Useful

    /// Set sample closure
    ///
    /// - Parameter closure: sample closure
    public func sample(_ closure: @escaping () -> Void) {
        if isDelaying {
            self.closure = closure
        } else {
            queue.async {
                closure()
            }
            self.closure = nil
            isDelaying = true
            queue.asyncAfter(deadline: .now() + delay) { [weak self] in
                self?.isDelaying = false
                if let closure = self?.closure {
                    self?.sample(closure)
                }
            }
        }
    }

    public func cancel() {
        closure = nil
    }
}
