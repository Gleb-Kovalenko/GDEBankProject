//
//  Timer.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 28.08.24.
//

import UIKit

private let timerQueue = DispatchQueue(label: "com.timer.queue", attributes: [])

// MARK: - Timer

final public class Timer: NSObject {

    // MARK: - Properties

    /// Internal timer instance
    private var timer: DispatchSourceTimer?

    /// Initial timer date
    public private(set) var startDate: Date?

    /// True if timer is active
    public var active: Bool {
        timer != nil
    }

    /// How many times timer's block was executed
    public private(set) var tickCount = 0

    /// True if we want to call timer action before first tick
    private let shouldStartWithAction: Bool

    /// Background mode holder
    private var bgTask: UIBackgroundTaskIdentifier?

    // MARK: - Initializers

    public init(shouldStartWithAction: Bool = false) {
        self.shouldStartWithAction = shouldStartWithAction
        super.init()
    }

    deinit {
        cancel()
    }

    // MARK: - Useful

    /// Start timer
    ///
    /// - Parameters:
    ///   - interval: tick interval (seconds)
    ///   - repeats: true if need to repeat timer closure
    ///   - handler: timer closure
    public func start(_ interval: TimeInterval, repeats: Bool = false, handler: @escaping () -> Void) {
        cancel()
        startDate = Date()
        let timer = DispatchSource.makeTimerSource(queue: timerQueue)
        self.timer = timer
        let interval = DispatchTimeInterval.milliseconds(Int(interval * 1_000))
        startBackgroundTask()
        timer.schedule(deadline: .now() + interval, repeating: interval)
        timer.setEventHandler {
            if !repeats {
                self.cancel()
            }
            self.tickCount += 1
            DispatchQueue.main.async(execute: handler)
        }
        if shouldStartWithAction {
            handler()
        }
        timer.resume()
    }

    /// Cancel timer ticks
    public func cancel() {
        endBackgroundTask()
        tickCount = 0
        guard let timer = timer else {
            return
        }
        timer.cancel()
        self.timer = nil
    }

    // MARK: - Internal

    public func update(tickCount: Int) {
        self.tickCount = tickCount
    }

    // MARK: - Private

    private func startBackgroundTask() {
        bgTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            guard let self = self else { return }
            self.endBackgroundTask()
        }
    }

    private func endBackgroundTask() {
        if let bgTask = bgTask {
            UIApplication.shared.endBackgroundTask(bgTask)
            self.bgTask = nil
        }
    }
}
