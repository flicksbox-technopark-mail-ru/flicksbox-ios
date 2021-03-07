//
//  HermesRequest.swift
//  FlicksBox
//
//  Created by sn.alekseev on 06.03.2021.
//

import Foundation

struct HermesResponse {
    let data: [AnyHashable: Any] // json
    let code: Int // код ответа
}

final class HermesRequest {
    var successHandler: ((HermesResponse) -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    let method: HermesMethod
    let path: String
    let params: [String: String]
    
    init(method: HermesMethod, path: String, params: [String: String]? = nil) {
        self.method = method
        self.path = path
        self.params = params ?? [:]
    }
}
