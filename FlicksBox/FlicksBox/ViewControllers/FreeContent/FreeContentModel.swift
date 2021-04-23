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
    private var filters = ContentFilters()
    
    func setGenreFilter(_ genre: Genre?) {
        guard let genre = genre else { return }
        self.filters.genre = genre.id
    }
    
    func setCountryFilter(_ country: Country?) {
        guard let country = country else { return }
        self.filters.country = country.id
    }
    
    func setYearFilter(_ year: Year?) {
        guard let year = year else { return }
        self.filters.year = year.value
    }

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
