//
//  APIUser.swift
//  FlicksBox
//
//  Created by sn.alekseev on 21.03.2021.
//

import Foundation

struct APIUser: Codable {
    var avatar: String
    var email: String
    var id: Int
    var nickname: String
}
