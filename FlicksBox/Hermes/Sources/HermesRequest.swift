//
//  HermesRequest.swift
//  FlicksBox
//
//  Created by sn.alekseev on 06.03.2021.
//

import Foundation

public struct HermesResponse {
    public let data: HermesData // json
    public let code: Int // код ответа
}

public final class HermesRequest {
    public var successHandler: ((HermesResponse) -> Void)?
    public var errorHandler: ((Error) -> Void)?
    
    let method: HermesMethod
    let path: String
    let params: [String: String]
    
    public init(method: HermesMethod, path: String, params: [String: String]? = nil) {
        self.method = method
        self.path = path
        self.params = params ?? [:]
    }
}
