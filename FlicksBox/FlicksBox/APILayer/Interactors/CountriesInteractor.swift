//
//  CountriesInteractor.swift
//  FlicksBox
//
//  Created by Mac-HOME on 19.04.2021.
//

import Foundation
import Hermes

final class CountriesInteractor {
    private let client: HermesClient
    private let encoder: JSONEncoder
    
    init() {
        client = HermesClient(with: "https://www.flicksbox.ru/api/v1")
        encoder = JSONEncoder()
    }
    
    struct CountriesResponse: Decodable {
        let countries: [APICountry]
    }
    
    func allCountries(
        success: @escaping (APIResponse<CountriesResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getCountries(
            path: "/countries",
            responseType: APIResponse<CountriesResponse>.self,
            success: success,
            failure: failure
        )
    }
    
    private func getCountries<T>(
        path: String,
        responseType: T.Type,
        success: @escaping (T) -> Void,
        failure: @escaping (Error) -> Void
    ) where T: Decodable {
        let request = HermesRequest(
            method: .get,
            path: path
        )
        request.successHandler = { response in
            guard let data = response.data.decode(type: T.self) else {
                failure(InteractorError.emptyData)
                return
            }
            success(data)
        }
        request.errorHandler = { error in
            failure(error)
        }
        client.run(with: request)
    }
}
