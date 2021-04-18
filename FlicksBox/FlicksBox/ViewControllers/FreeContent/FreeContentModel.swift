//
//  FreeContentModel.swift
//  FlicksBox
//
//  Created by Mac-HOME on 18.04.2021.
//

import Foundation

final class FreeContentModel: NSObject {
    private let interactor = ContentInteractor()

    private let from = 0
    private let count = 30
    let filters = ContentFilters()

    func loadData(success: @escaping ([FilmInfo]) -> Void, failure: @escaping (String) -> Void) {
        interactor.filtredContent(from: from, count: count, filters: filters) { response in
            success(self.trasformate(content: response.body!))
        } failure: { error in
            failure(error.localizedDescription)
        }
    }

    private func trasformate(content: ContentResponse) -> [FilmInfo] {
        let movies = content.movies.map { movie -> FilmInfo in
            FilmInfo(from: movie)
        }
        let tvshows = content.tvshows.map { tvshow -> FilmInfo in
            FilmInfo(from: tvshow)
        }
        return movies + tvshows
    }
}
