//
//  HermesResponse.swift
//  FlicksBox
//
//  Created by sn.alekseev on 07.03.2021.
//

import Foundation

struct HermesResponse {
    let data: [AnyHashable: Any] // json
    let code: Int // код ответа
}
