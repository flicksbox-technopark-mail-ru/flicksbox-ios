//
//  NetworkError.swift
//  FlicksBox
//
//  Created by sn.alekseev on 20.03.2021.
//

import Foundation

struct APIResponse<T>: Decodable where T: Decodable {
    var value: T?
    var error: APIError?
}

struct APIError: Decodable {
    var code: Int
    var message: String
    var user_message: String
}
