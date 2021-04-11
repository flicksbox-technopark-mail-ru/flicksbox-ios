//
//  FilmsInteractor.swift
//  FlicksBox
//
//  Created by sn.alekseev on 11.04.2021.
//

import Foundation
import Hermes

final class FilmsInteractor {
    private let client: HermesClient
    
    private let encoder: JSONEncoder
    
    init() {
        client = HermesClient(with: "https://www.flicksbox.ru/api/v1")
        encoder = JSONEncoder()
    }
    
}
