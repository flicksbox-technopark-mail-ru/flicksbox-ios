//
//  APIUser.swift
//  FlicksBox
//
//  Created by sn.alekseev on 21.03.2021.
//

import Foundation

struct APIUser: Codable {
    let avatar: String
    let email: String
    let id: Int
    let nickname: String
}
