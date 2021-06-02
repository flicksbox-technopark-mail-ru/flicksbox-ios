//
//  ActorModel.swift
//  FlicksBox
//
//  Created by Mac-HOME on 01.06.2021.
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

class ActorModel: NSObject {
    private let interactor = ContentInteractor()
    private var filters = ContentFilters()
    
    func loadData(actor: Actor, success: @escaping ([ContentInfo]) -> Void, failure: @escaping (String) -> Void) {
        self.filters.actor = actor.id
        interactor.filtredContent(from: 0, count: 30, filters: filters) { response in
            guard let body = response.body else {
                failure("Неизвестная ошибка")
                return
            }
            success(self.trasformate(content: body))
        } failure: { error in
            failure(error.localizedDescription)
        }
    }

    private func trasformate(content: ContentResponse) -> [ContentInfo] {
        let movies = content.movies.map { movie -> ContentInfo in
            ContentInfo(from: movie)
        }
        let tvshows = content.tvshows.map { tvshow -> ContentInfo in
            ContentInfo(from: tvshow)
        }
        return movies + tvshows
    }
}
