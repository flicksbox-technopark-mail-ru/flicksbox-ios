//
//  SearchModel.swift
//  FlicksBox
//
//  Created by Mac-HOME on 23.04.2021.
//

import Foundation

struct SearchResult {
    let actors: [Actor]
    let content: [ContentInfo]
    
    init(actors: [Actor], content: [ContentInfo]) {
        self.actors = actors
        self.content = content
    }
}

final class SearchModel: NSObject {
    private let interactor = SearchInteractor()
    private let from = 0
    private let count = 20

    func search(query: String, success: @escaping (SearchResult) -> Void, failure: @escaping (String) -> Void) {
        interactor.search(from: from, count: count, query: query) { response in
            success(self.trasformate(resp: response.body ?? nil))
        } failure: { error in
            failure(error.localizedDescription)
        }
    }

    private func trasformate(resp: SearchResponse?) -> SearchResult {
        guard let resp = resp else {
            return SearchResult(actors: [], content: [])
        }
        let movies = resp.result.movies.map { movie -> ContentInfo in
            ContentInfo(from: movie)
        }
        let tvshows = resp.result.tv_shows.map { tvshow -> ContentInfo in
            ContentInfo(from: tvshow)
        }
        let actors = resp.result.actors.map { actor -> Actor in
            Actor(from: actor)
        }
        let searchResult = SearchResult(actors: actors, content: movies + tvshows)
        return searchResult
    }
}
