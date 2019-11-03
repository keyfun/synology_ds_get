//
//  UserDefaultsUtils.swift
//  DSGetLite
//
//  Created by Hui Key on 18/10/2016.
//  Copyright © 2016 Key Hui. All rights reserved.
//

import Foundation

final class UserDefaultsUtils {

    fileprivate static let kAddress = "address"
    fileprivate static let kAccount = "account"
    fileprivate static let kPassword = "password"

    fileprivate static let userDefaults: UserDefaults = UserDefaults.standard

    static func loadAddress() -> String {
        return load(kAddress, defaultValue: "")
    }

    static func saveAddress(value: String) {
        save(kAddress, value: value)
    }

    static func loadAccount() -> String {
        return load(kAccount, defaultValue: "")
    }

    static func saveAccount(value: String) {
        save(kAccount, value: value)
    }

    static func loadPassword() -> String {
        return load(kPassword, defaultValue: "")
    }

    static func savePassword(value: String) {
        save(kPassword, value: value)
    }

    static func save(_ key: String, value: Bool) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }

    static func load(_ key: String, defaultValue: Bool) -> Bool {
        var tmpValue: Bool = false
        if let value = userDefaults.object(forKey: key) {
            tmpValue = value as! Bool
        } else {
            tmpValue = defaultValue
        }
        return tmpValue
    }

    static func save(_ key: String, value: String) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }

    static func load(_ key: String, defaultValue: String) -> String {
        var tmpValue: String = ""
        if let value = userDefaults.object(forKey: key) {
            tmpValue = value as! String
        } else {
            tmpValue = defaultValue
        }
        return tmpValue
    }
}
