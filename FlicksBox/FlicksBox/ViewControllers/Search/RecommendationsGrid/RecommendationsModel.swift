//
//  RecommendationsModel.swift
//  FlicksBox
//
//  Created by Mac-HOME on 25.04.2021.
//

import Foundation

final class RecommendationsModel: NSObject {
    private let interactor = RecommendationsInteractor()

    func loadData(success: @escaping ([FilmInfo]) -> Void, failure: @escaping (String) -> Void) {
        interactor.recommendations() { response in
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
        return (movies + tvshows).shuffled()
    }
}
