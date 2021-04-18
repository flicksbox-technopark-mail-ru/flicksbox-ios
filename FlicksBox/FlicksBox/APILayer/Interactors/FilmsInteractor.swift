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
    
    struct MoviesResponse: Decodable {
        let movies: [APIMovie]
    }
    
    func topMovies(
        from: Int,
        count: Int,
        success: @escaping (APIResponse<MoviesResponse>) -> Void,
        failure: @escaping (Error) -> Void) {
        let request = HermesRequest(
            method: .get,
            path: "/movies/top", body: nil,
            headers: nil,
            params: [
                "count": "\(count)",
                "from": "\(from)"
            ]
        )
        request.successHandler = { response in
            guard let data = response.data.decode(type: APIResponse<MoviesResponse>.self) else {
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
