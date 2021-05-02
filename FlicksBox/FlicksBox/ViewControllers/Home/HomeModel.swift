//
//  HomeModel.swift
//  FlicksBox
//
//  Created by sn.alekseev on 11.04.2021.
//

import Foundation

struct ContentListInfo {
    enum ContentListType: Int {
        case topMovies = 0
        case lastMovies
        case topSerials
        case lastSerials
    }

    let name: String
    let type: ContentListType
}

struct ContentInfo {
    enum ContentType {
        case movie
        case tvshow
        
        init(apiType: APIContentType) {
            switch apiType {
            case .movie:
                self = .movie
            case .tvshow:
                self = .tvshow
            }
        }
    }
    
    let id: Int
    let contentId: Int
    let name: String
    let image: String
    let year: Int
    let type: ContentType
    
    init(from movie: APIMovie) {
        self.init(id: movie.id, contentId: movie.content_id, name: movie.name, image: movie.images, year: movie.year, type: ContentType(apiType: movie.type))
    }
    
    init(from tvShow: APITVShow) {
        self.init(id: tvShow.id, contentId: tvShow.content_id, name: tvShow.name, image: tvShow.images, year: tvShow.year, type: ContentType(apiType: tvShow.type))
    }
    
    private init(id: Int, contentId: Int, name: String, image: String, year: Int, type: ContentType) {
        self.id = id
        self.contentId = contentId
        self.name = name
        self.image = "https://www.flicksbox.ru\(image)/640"
        self.year = year
        self.type = type
    }
}

final class HomeModel: NSObject {
    private let interactor = FilmsInteractor()
    
    let sectionsInfo: [ContentListInfo] = [
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
    
    func loadSection(index: Int, success: @escaping ([ContentInfo]) -> Void, failure: @escaping (String) -> Void) {
        let type = ContentListInfo.ContentListType(rawValue: index)
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
    
    private func trasformate(movies: [APIMovie]) -> [ContentInfo] {
        movies.map { movie -> ContentInfo in
            ContentInfo(from: movie)
        }
    }
    
    private func trasformate(movies: [APITVShow]) -> [ContentInfo] {
        movies.map { movie -> ContentInfo in
            ContentInfo(from: movie)
        }
    }
}
