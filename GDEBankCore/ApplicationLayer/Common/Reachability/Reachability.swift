//
//  Reachability.swift
//  GDEBank
//
//  Created by incetro on 6/5/20.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//
// swiftlint:disable identifier_name

import Foundation
import SystemConfiguration

// MARK: - ReachabilityError

public enum ReachabilityError: Error {
    case failedToCreateWithAddress(sockaddr_in)
    case failedToCreateWithHostname(String)
    case unableToSetCallback
    case unableToSetDispatchQueue
    case unableToGetInitialFlags
}

// MARK: - Notification

extension Foundation.Notification.Name {
    static let reachabilityChanged = Foundation.Notification.Name("reachabilityChanged")
}

// MARK: - Reachability

public final class Reachability {

    // MARK: - Aliases

    public typealias NetworkReachable = (Reachability) -> Void
    public typealias NetworkUnreachable = (Reachability) -> Void

    // MARK: - Connection

    public enum Connection: CustomStringConvertible {

        case none
        case wifi
        case cellular

        public var description: String {
            switch self {
            case .cellular:
                return "Cellular"
            case .wifi:
                return "WiFi"
            case .none:
                return "No Connection"
            }
        }
    }

    // MARK: - Properties

    public var whenReachable: NetworkReachable?
    public var whenUnreachable: NetworkUnreachable?

    /// Set to `false` to force Reachability.connection to .none when on cellular connection (default value `true`)
    public var allowsCellularConnection: Bool

    // The notification center on which "reachability changed" events are being posted
    public var notificationCenter: NotificationCenter = NotificationCenter.default

    public var connection: Connection {
        if flags == nil {
            try? setReachabilityFlags()
        }
        switch flags?.connection {
        case .none?, nil:
            return .none
        case .cellular?:
            return allowsCellularConnection ? .cellular : .none
        case .wifi?:
            return .wifi
        }
    }

    private var isRunningOnDevice: Bool = {
        #if targetEnvironment(simulator)
        return false
        #else
        return true
        #endif
    }()

    private var notifierRunning = false
    private let reachabilityRef: SCNetworkReachability
    private let reachabilitySerialQueue: DispatchQueue
    private(set) var flags: SCNetworkReachabilityFlags? {
        didSet {
            guard flags != oldValue else {
                return
            }
            reachabilityChanged()
        }
    }

    required public init(reachabilityRef: SCNetworkReachability, queueQoS: DispatchQoS = .default, targetQueue: DispatchQueue? = nil) {
        self.allowsCellularConnection = true
        self.reachabilityRef = reachabilityRef
        self.reachabilitySerialQueue = DispatchQueue(label: "incetro.reachability", qos: queueQoS, target: targetQueue)
    }

    public convenience init?(hostname: String, queueQoS: DispatchQoS = .default, targetQueue: DispatchQueue? = nil) {
        guard let ref = SCNetworkReachabilityCreateWithName(nil, hostname) else {
            return nil
        }
        self.init(reachabilityRef: ref, queueQoS: queueQoS, targetQueue: targetQueue)
    }

    public convenience init?(queueQoS: DispatchQoS = .default, targetQueue: DispatchQueue? = nil) {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zeroAddress.sa_family = sa_family_t(AF_INET)
        guard let ref = SCNetworkReachabilityCreateWithAddress(nil, &zeroAddress) else {
            return nil
        }
        self.init(reachabilityRef: ref, queueQoS: queueQoS, targetQueue: targetQueue)
    }

    deinit {
        stopNotifier()
    }
}

extension Reachability {

    func startNotifier() throws {

        guard !notifierRunning else {
            return
        }

        let callback: SCNetworkReachabilityCallBack = { reachability, flags, info in

            guard let info = info else {
                return
            }

            let reachability = Unmanaged<Reachability>.fromOpaque(info).takeUnretainedValue()
            reachability.flags = flags
        }

        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        context.info = UnsafeMutableRawPointer(Unmanaged<Reachability>.passUnretained(self).toOpaque())
        if !SCNetworkReachabilitySetCallback(reachabilityRef, callback, &context) {
            stopNotifier()
            throw ReachabilityError.unableToSetCallback
        }

        if !SCNetworkReachabilitySetDispatchQueue(reachabilityRef, reachabilitySerialQueue) {
            stopNotifier()
            throw ReachabilityError.unableToSetDispatchQueue
        }

        // Perform an initial check
        try setReachabilityFlags()

        notifierRunning = true
    }

    func stopNotifier() {
        defer {
            notifierRunning = false
        }
        SCNetworkReachabilitySetCallback(reachabilityRef, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(reachabilityRef, nil)
    }

    var isReachable: Bool {
        connection != .none
    }

    var isReachableViaWWAN: Bool {
        connection == .cellular
    }

    var isReachableViaWiFi: Bool {
        connection == .wifi
    }

    var description: String {
        guard let flags = flags else {
            return "unavailable flags"
        }
        let W = isRunningOnDevice ? (flags.isOnWWANFlagSet ? "W" : "-") : "X"
        let R = flags.isReachableFlagSet ? "R" : "-"
        let c = flags.isConnectionRequiredFlagSet ? "c" : "-"
        let t = flags.isTransientConnectionFlagSet ? "t" : "-"
        let i = flags.isInterventionRequiredFlagSet ? "i" : "-"
        let C = flags.isConnectionOnTrafficFlagSet ? "C" : "-"
        let D = flags.isConnectionOnDemandFlagSet ? "D" : "-"
        let l = flags.isLocalAddressFlagSet ? "l" : "-"
        let d = flags.isDirectFlagSet ? "d" : "-"
        return "\(W)\(R) \(c)\(t)\(i)\(C)\(D)\(l)\(d)"
    }
}

extension Reachability {

    func setReachabilityFlags() throws {
        try reachabilitySerialQueue.sync { [unowned self] in
            var flags = SCNetworkReachabilityFlags()
            if !SCNetworkReachabilityGetFlags(self.reachabilityRef, &flags) {
                self.stopNotifier()
                throw ReachabilityError.unableToGetInitialFlags
            }
            self.flags = flags
        }
    }

    func reachabilityChanged() {
        let block = connection != .none ? whenReachable : whenUnreachable
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            block?(self)
            self.notificationCenter.post(name: .reachabilityChanged, object: self)
        }
    }
}

extension SCNetworkReachabilityFlags {

    typealias Connection = Reachability.Connection

    var connection: Connection {

        guard isReachableFlagSet else {
            return .none
        }

        #if targetEnvironment(simulator)
        return .wifi
        #else
        var connection = Connection.none

        if !isConnectionRequiredFlagSet {
            connection = .wifi
        }

        if isConnectionOnTrafficOrDemandFlagSet {
            if !isInterventionRequiredFlagSet {
                connection = .wifi
            }
        }

        if isOnWWANFlagSet {
            connection = .cellular
        }

        return connection
        #endif
    }

    var isOnWWANFlagSet: Bool {
        #if os(iOS)
        return contains(.isWWAN)
        #else
        return false
        #endif
    }

    var isReachableFlagSet: Bool {
        contains(.reachable)
    }

    var isConnectionRequiredFlagSet: Bool {
        contains(.connectionRequired)
    }

    var isInterventionRequiredFlagSet: Bool {
        contains(.interventionRequired)
    }

    var isConnectionOnTrafficFlagSet: Bool {
        contains(.connectionOnTraffic)
    }

    var isConnectionOnDemandFlagSet: Bool {
        contains(.connectionOnDemand)
    }

    var isConnectionOnTrafficOrDemandFlagSet: Bool {
        !intersection([.connectionOnTraffic, .connectionOnDemand]).isEmpty
    }

    var isTransientConnectionFlagSet: Bool {
        contains(.transientConnection)
    }

    var isLocalAddressFlagSet: Bool {
        contains(.isLocalAddress)
    }

    var isDirectFlagSet: Bool {
        contains(.isDirect)
    }

    var isConnectionRequiredAndTransientFlagSet: Bool {
        intersection([.connectionRequired, .transientConnection]) == [.connectionRequired, .transientConnection]
    }
}

extension Reachability {

    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability.unsafelyUnwrapped, &flags) == false {
            return false
        }

        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret
    }
}
