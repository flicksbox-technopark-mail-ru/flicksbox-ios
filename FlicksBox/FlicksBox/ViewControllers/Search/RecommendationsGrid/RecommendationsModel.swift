//
//  RecommendationsModel.swift
//  FlicksBox
//
//  Created by Mac-HOME on 25.04.2021.
//

import Foundation

final class RecommendationsModel: NSObject {
    private let interactor = RecommendationsInteractor()

    func loadData(success: @escaping ([ContentInfo]) -> Void, failure: @escaping (String) -> Void) {
        interactor.recommendations() { response in
            success(self.trasformate(content: response.body!))
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
        return (movies + tvshows).shuffled()
    }
}
