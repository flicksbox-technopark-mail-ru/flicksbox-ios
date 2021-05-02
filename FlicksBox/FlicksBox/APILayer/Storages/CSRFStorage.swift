//
//  CSRFStorage.swift
//  FlicksBox
//
//  Created by sn.alekseev on 21.03.2021.
//

import Foundation

final class CSRFStorage {
    static let shared = CSRFStorage()

    private init() {}

    var token: String?
}
