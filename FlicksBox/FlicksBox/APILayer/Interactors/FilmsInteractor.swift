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
        failure: @escaping (Error) -> Void
    ) {
        getMoviesForTop(
            path: "/movies/top",
            responseType: APIResponse<MoviesResponse>.self,
            from: from,
            count: count,
            success: success,
            failure: failure
        )
    }
    
    func latestMovies(
        from: Int,
        count: Int,
        success: @escaping (APIResponse<MoviesResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getMoviesForTop(
            path: "/movies/latest",
            responseType: APIResponse<MoviesResponse>.self,
            from: from,
            count: count,
            success: success,
            failure: failure
        )
    }
    
    struct TVShowResponse: Decodable {
        let tvshows: [APITVShow]
    }
    
    func topTVShows(
        from: Int,
        count: Int,
        success: @escaping (APIResponse<TVShowResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getMoviesForTop(
            path: "/tvshows/top",
            responseType: APIResponse<TVShowResponse>.self,
            from: from,
            count: count,
            success: success,
            failure: failure
        )
    }
    
    func latestTVShows(
        from: Int,
        count: Int,
        success: @escaping (APIResponse<TVShowResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getMoviesForTop(
            path: "/tvshows/latest",
            responseType: APIResponse<TVShowResponse>.self,
            from: from,
            count: count,
            success: success,
            failure: failure
        )
    }
    
    private func getMoviesForTop<T>(
        path: String,
        responseType: T.Type,
        from: Int,
        count: Int,
        success: @escaping (T) -> Void,
        failure: @escaping (Error) -> Void
    ) where T: Decodable{
        let request = HermesRequest(
            method: .get,
            path: path, body: nil,
            headers: nil,
            params: [
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
