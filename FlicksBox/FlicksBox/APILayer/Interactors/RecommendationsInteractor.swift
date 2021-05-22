//
//  RecomendationInteractor.swift
//  FlicksBox
//
//  Created by Mac-HOME on 25.04.2021.
//

import Foundation
import Hermes

final class RecommendationsInteractor {
    private let client: HermesClient
    private let encoder: JSONEncoder
    
    init() {
        client = HermesClient(with: "https://www.flicksbox.ru/api/v1")
        encoder = JSONEncoder()
    }
    
    func recommendations(
        success: @escaping (APIResponse<ContentResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getRecommendations(
            path: "/content",
            responseType: APIResponse<ContentResponse>.self,
            success: success,
            failure: failure
        )
    }
    
    private func getRecommendations<T>(
        path: String,
        responseType: T.Type,
        success: @escaping (T) -> Void,
        failure: @escaping (Error) -> Void
    ) where T: Decodable {
        let request = HermesRequest(
            method: .get,
            path: path,
            params: [
                "count": "15",
                "from": "\(Int.random(in: 0..<7))" // 22 movies and tvshows in db
            ]
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
