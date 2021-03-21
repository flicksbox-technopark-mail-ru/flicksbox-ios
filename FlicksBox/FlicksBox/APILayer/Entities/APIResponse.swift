//
//  APIResponse.swift
//  FlicksBox
//
//  Created by sn.alekseev on 21.03.2021.
//

import Foundation

struct APIError: Decodable {
    var code: Int
    var message: String
    var user_message: String
}

struct APIResponse<T>: Decodable where T: Decodable {
    var body: T?
    var error: APIError?
}
