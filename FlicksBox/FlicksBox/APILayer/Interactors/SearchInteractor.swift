//
//  SearchInteractor.swift
//  FlicksBox
//
//  Created by Mac-HOME on 23.04.2021.
//

import Foundation
import Hermes

struct SearchResponse: Decodable {
    let result: APIResult
}

final class SearchInteractor: BaseInteractor {
    
    func search(
        from: Int,
        count: Int,
        query: String,
        success: @escaping (APIResponse<SearchResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getSearchResult(
            path: "/search",
            responseType: APIResponse<SearchResponse>.self,
            from: from,
            count: count,
            query: query,
            success: success,
            failure: failure
        )
    }
    
    private func getSearchResult<T>(
        path: String,
        responseType: T.Type,
        from: Int,
        count: Int,
        query: String,
        success: @escaping (T) -> Void,
        failure: @escaping (Error) -> Void
    ) where T: Decodable {
        let request = HermesRequest(
            method: .get,
            path: path,
            params: [
                "q": query,
                "count": "\(count)",
                "from": "\(from)"
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
