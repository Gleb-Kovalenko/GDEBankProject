//
//  Device.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 3.08.24.
//

import Foundation
import UIKit
import LocalAuthentication

// MARK: - UIDevice

extension UIDevice {
    
    public var bangType: DeviceBangType? {
        if UIDevice().hasDynamicIsland() {
            return .dynamicIsland
        }
        if UIDevice().isFaceIDAvailable() {
            return .bang
        }
        return nil
    }
    
    public func hasDynamicIsland() -> Bool {
        var name = ""
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            name = simulatorModelIdentifier.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
        } else {
            var sysinfo = utsname()
            uname(&sysinfo)
            name = String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!
                .trimmingCharacters(in: .controlCharacters)
                .replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
        }
        guard let deviceNumber = Int(name) else { return false }
        return deviceNumber >= 152
    }
    
    public func isFaceIDAvailable() -> Bool {
        let context = LAContext()
        return (context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: nil) && context.biometryType == .faceID)
    }
}
