//
//  BaseInteractor.swift
//  FlicksBox
//
//  Created by sn.alekseev on 02.06.2021.
//

import Hermes

class BaseInteractor {
    let client: HermesClient
    
    let encoder: JSONEncoder
    
    convenience init() {
        self.init(base: "https://www.flicksbox.ru/api/v1")
    }
    
    init(base baseUrl: String) {
        client = HermesClient(with: baseUrl)
        encoder = JSONEncoder()
    }
}
