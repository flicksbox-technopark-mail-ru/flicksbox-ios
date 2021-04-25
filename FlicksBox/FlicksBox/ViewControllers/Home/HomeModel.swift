//
//  HomeModel.swift
//  FlicksBox
//
//  Created by sn.alekseev on 11.04.2021.
//

import Foundation

enum FilmsListType: Int {
    case topMovies = 0
    case lastMovies
    case topSerials
    case lastSerials
}

struct FilmsListInfo {
    let name: String
    let type: FilmsListType
}

struct FilmInfo {
    let id: Int
    let contentId: Int
    let name: String
    let image: String
    let year: Int
    
    init(from movie: APIMovie) {
        self.init(id: movie.id, contentId: movie.content_id, name: movie.name, image: movie.images, year: movie.year)
    }
    
    init(from tvShow: APITVShow) {
        self.init(id: tvShow.id, contentId: tvShow.content_id, name: tvShow.name, image: tvShow.images, year: tvShow.year)
    }
    
    private init(id: Int, contentId: Int, name: String, image: String, year: Int) {
        self.id = id
        self.contentId = contentId
        self.name = name
        self.image = "https://www.flicksbox.ru\(image)/640"
        self.year = year
    }
}

final class HomeModel: NSObject {
    private let interactor = FilmsInteractor()
    
    let sectionsInfo: [FilmsListInfo] = [
        .init(name: "Топ фильмов", type: .topMovies),
        .init(name: "Последние фильмы", type: .lastMovies),
        .init(name: "Топ сериалов", type: .topSerials),
        .init(name: "Последние сериалы", type: .topSerials)
    ]
    
    var countSections: Int {
        return sectionsInfo.count
    }
    
    private let from = 0
    private let count = 15
    
    func loadSection(index: Int, success: @escaping ([FilmInfo]) -> Void, failure: @escaping (String) -> Void) {
        let type = FilmsListType(rawValue: index)
        switch type {
        case .topMovies:
            interactor.topMovies(from: from, count: count) { response in
                success(self.trasformate(movies: response.body?.movies ?? []))
            } failure: { error in
                failure(error.localizedDescription)
            }
        case .lastMovies:
            interactor.latestMovies(from: from, count: count) { response in
                success(self.trasformate(movies: response.body?.movies ?? []))
            } failure: { error in
                failure(error.localizedDescription)
            }
        case .topSerials:
            interactor.topTVShows(from: from, count: count) { response in
                success(self.trasformate(movies: response.body?.tvshows ?? []))
            } failure: { error in
                failure(error.localizedDescription)
            }
        case .lastSerials:
            interactor.latestTVShows(from: from, count: count) { response in
                success(self.trasformate(movies: response.body?.tvshows ?? []))
            } failure: { error in
                failure(error.localizedDescription)
            }
        default:
            break
        }
    }
    
    private func trasformate(movies: [APIMovie]) -> [FilmInfo] {
        movies.map { movie -> FilmInfo in
            FilmInfo(from: movie)
        }
    }
    
    private func trasformate(movies: [APITVShow]) -> [FilmInfo] {
        movies.map { movie -> FilmInfo in
            FilmInfo(from: movie)
        }
    }
}
