//
//  ContentInteractor.swift
//  FlicksBox
//
//  Created by Mac-HOME on 19.04.2021.
//

import Foundation
import Hermes

struct ContentResponse: Decodable {
    let movies: [APIMovie]
    let tvshows: [APITVShow]
}

struct ContentFilters: Decodable {
    var year: Int?
    var genre: Int?
    var country: Int?
    var actor: Int?
    var director: Int?
    var is_free: Bool?
}

final class ContentInteractor {
    private let client: HermesClient
    private let encoder: JSONEncoder

    init() {
        client = HermesClient(with: "https://www.flicksbox.ru/api/v1")
        encoder = JSONEncoder()
    }

    func filtredContent(
        from: Int,
        count: Int,
        filters: ContentFilters,
        success: @escaping (APIResponse<ContentResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getContent(
            path: "/content",
            responseType: APIResponse<ContentResponse>.self,
            from: from,
            count: count,
            filters: filters,
            success: success,
            failure: failure
        )
    }

    private func getContent<T>(
        path: String,
        responseType: T.Type,
        from: Int,
        count: Int,
        filters: ContentFilters,
        success: @escaping (T) -> Void,
        failure: @escaping (Error) -> Void
    ) where T: Decodable {
        var params = [
            "count": "\(count)",
            "from": "\(from)"
        ]

        // TODO make via iterations
        if let year = filters.year {
            params["year"] = "\(year)"
        }
        if let genre = filters.genre {
            params["genre"] = "\(genre)"
        }
        if let country = filters.country {
            params["country"] = "\(country)"
        }
        if let actor = filters.actor {
            params["actor"] = "\(actor)"
        }
        if let director = filters.director {
            params["director"] = "\(director)"
        }
        if let is_free = filters.is_free {
            params["is_free"] = "\(is_free)"
        }

        let request = HermesRequest(
            method: .get,
            path: path,
            params: params
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
