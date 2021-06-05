//
//  RatingInteractor.swift
//  FlicksBox
//
//  Created by sn.alekseev on 02.06.2021.
//

import Foundation
import Hermes

final class RatingInteractor: BaseInteractor {
    
    private struct RatingResponse: Decodable {
        let match: Int
    }
    
    func get(
        contentId: Int,
        success: @escaping (Int) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        let request = HermesRequest(method: .get, path: "/movies/\(contentId)/rating")
        request.successHandler = { response in
            guard let match = response.data.decode(type: APIResponse<RatingResponse>.self)?.body?.match else {
                failure(InteractorError.emptyData)
                return
            }
            success(match)
        }
        request.errorHandler = { error in
            failure(error)
        }
        client.run(with: request)
    }
    
    private struct RatingRequest: Encodable {
        let likes: Bool
    }
    
    func rate(
        id: Int,
        like: Bool,
        change: Bool,
        success: @escaping () -> Void,
        failure: @escaping (Error) -> Void
    ) {
        guard let data = try? encoder.encode(RatingRequest(likes: like)) else {
            failure(InteractorError.invalidEncode)
            return
        }
        let request = HermesRequest(
            method: change ? .put : .post,
            path: "/rating/\(id)",
            body: data,
            headers: ["X-Csrf-Token": CSRFStorage.shared.token ?? ""]
        )
        request.successHandler = { response in
            success()
        }
        request.errorHandler = { error in
            failure(error)
        }
        client.run(with: request)
    }
}
    
    
