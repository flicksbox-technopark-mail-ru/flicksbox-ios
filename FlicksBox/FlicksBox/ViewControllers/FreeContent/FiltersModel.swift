//
//  FiltersModel.swift
//  FlicksBox
//
//  Created by Mac-HOME on 19.04.2021.
//

import Foundation

//final class FiltersModel: NSObject {
//    private let interactor = FiltersInteractor()
//
//    func loadGenres(success: @escaping ([FilmInfo]) -> Void, failure: @escaping (String) -> Void) {
//        interactor.filtredContent(from: from, count: count, filters: filters) { response in
//            success(self.trasformate(content: response.body!))
//        } failure: { error in
//            failure(error.localizedDescription)
//        }
//    }
//
//    func loadCountries(success: @escaping ([FilmInfo]) -> Void, failure: @escaping (String) -> Void) {
//        interactor.filtredContent(from: from, count: count, filters: filters) { response in
//            success(self.trasformate(content: response.body!))
//        } failure: { error in
//            failure(error.localizedDescription)
//        }
//    }
//
//    private func trasformate(content: ContentResponse) -> [FilmInfo] {
//        let movies = content.movies.map { movie -> FilmInfo in
//            FilmInfo(from: movie)
//        }
//        let tvshows = content.tvshows.map { tvshow -> FilmInfo in
//            FilmInfo(from: tvshow)
//        }
//        return movies + tvshows
//    }
//}
