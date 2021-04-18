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
    let name: String
    let image: String
    
    init(from movie: APIMovie) {
        id = movie.id
        name = movie.name
        image = "https://www.flicksbox.ru\(movie.images)"
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
                let movies = response.body?.movies ?? []
                let films: [FilmInfo] = movies.map { movie -> FilmInfo in
                    FilmInfo(from: movie)
                }
                success(films)
            } failure: { error in
                failure(error.localizedDescription)
            }
        case .lastMovies:
            break
        case .topSerials:
            break
        case .lastSerials:
            break
        default:
            break
        }
    }
}
