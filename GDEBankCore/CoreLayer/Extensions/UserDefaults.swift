//
//  UserDefaults.swift
//  GDEBank
//
//  Created by incetro on 03/12/2019.
//  Copyright © 2019 Incetro Inc. All rights reserved.
//

import Foundation

// MARK: - UserDefaults

extension UserDefaults {
    
    public static var appGroup: UserDefaults? {
        UserDefaults(suiteName: AppConstants.Sharing.appGroupName)
    }
    
    /// Get user data
    public static func userData() -> (phone: String?, email: String?) {
        let phone = UserDefaults.standard.value(forKey: .userPhone) as? String
        let email = UserDefaults.standard.value(forKey: .userEmail) as? String
        return (phone: phone, email: email)
    }
    
    /// Save user data
    public static func save(phone: String? = nil, email: String? = nil) {
        if let phone {
            UserDefaults.standard.setValue(phone, forKey: .userPhone)
        }
        if let email {
            UserDefaults.standard.setValue(email, forKey: .userEmail)
        }
        print("✅ User data saved")
    }
    
    /// Clear user data
    public static func clearUserData() {
        UserDefaults.standard.removeValue(forKey: .userPhone)
        UserDefaults.standard.removeValue(forKey: .userEmail)
    }

    public func setValue(_ value: Any, forKey key: AppConstants.UserDefaultsKeys) {
        setValue(value, forKey: key.rawValue)
    }

    public func removeValue(forKey key: AppConstants.UserDefaultsKeys) {
        removeObject(forKey: key.rawValue)
    }

    public func cache<T: Codable>(value: T?, forKey key: AppConstants.UserDefaultsKeys) {
        do {
            if let value = value {
                let data = try JSONEncoder().encode(value)
                setValue(data, forKey: key.rawValue)
                
            } else {
            }
        } catch {
//            log.error(error)
        }
    }

    public func retrieve<T: Codable>(forKey key: AppConstants.UserDefaultsKeys) -> T? {
        guard let data = value(forKey: key.rawValue) as? Data else {
            return nil
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
//            log.error(error)
            fatalError(error.localizedDescription)
        }
    }

    public func value<T>(forKey key: AppConstants.UserDefaultsKeys, default val: T) -> T {
        (value(forKey: key.rawValue) as? T) ?? val
    }
    
    public func value(forKey key: AppConstants.UserDefaultsKeys) -> Any? {
        value(forKey: key.rawValue)
    }

    public func value<T>(forKey key: String, default val: T) -> T {
        (value(forKey: key) as? T) ?? val
    }
}
