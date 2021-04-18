//
//  APIResponse.swift
//  FlicksBox
//
//  Created by sn.alekseev on 21.03.2021.
//

import Foundation

enum InteractorError: Error {
    case emptyData
    case invalidEncode
}

struct APIError: Decodable {
    let code: Int
    let message: String
    let user_message: String
}

struct APIResponse<T>: Decodable where T: Decodable {
    let body: T?
    let error: APIError?
}
