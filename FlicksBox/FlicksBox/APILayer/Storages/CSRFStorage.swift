//
//  CSRFStorage.swift
//  FlicksBox
//
//  Created by sn.alekseev on 21.03.2021.
//

import Foundation

final class CSRFStorage {
    static let shared = CSRFStorage()
    
    private let userDefaults = UserDefaults.standard
    private let key = "flicksbox.csrf"
    
    private init() {}
    
    var token: String? {
        get {
            userDefaults.string(forKey: key)
        }
        set {
            userDefaults.setValue(newValue, forKey: key)
        }
    }
}
