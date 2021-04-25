//
//  SearchModel.swift
//  FlicksBox
//
//  Created by Mac-HOME on 23.04.2021.
//

import Foundation

struct Actor {
    let id: Int
    let name: String
    
    init(from actor: APIActor) {
        self.init(id: actor.id, name: actor.name)
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

struct SearchResult {
    let actor: [Actor]
    let content: [FilmInfo]
    
    init(actor: [Actor], content: [FilmInfo]) {
        self.actor = actor
        self.content = content
    }
}

final class SearchModel: NSObject {
    private let interactor = SearchInteractor()
    private let from = 0
    private let count = 20

    func search(query: String, success: @escaping (SearchResult) -> Void, failure: @escaping (String) -> Void) {
        interactor.search(from: from, count: count, query: query) { response in
            success(self.trasformate(resp: response.body!))
        } failure: { error in
            failure(error.localizedDescription)
        }
    }

    private func trasformate(resp: SearchResponse) -> SearchResult {
        let movies = resp.movies.map { movie -> FilmInfo in
            FilmInfo(from: movie)
        }
        let tvshows = resp.tvshows.map { tvshow -> FilmInfo in
            FilmInfo(from: tvshow)
        }
        let actors = resp.actors.map { actor -> Actor in
            Actor(from: actor)
        }
        let searchResult = SearchResult(actor: actors, content: movies + tvshows)
        return searchResult
    }
}
