//
//  MainPageModel.swift
//  FlicksBox
//
//  Created by Mac-HOME on 20.05.2021.
//

import Foundation

struct MainPageContent: PageContent {
    enum ContentListType: Int {
        case topMovies = 0
        case lastMovies
        case topSerials
        case lastSerials
    }

    let name: String
    let type: ContentListType
}

final class MainPageModel: NSObject, PageModel {
    private let interactor = FilmsInteractor()
    private let contentInteractor = ContentInteractor()
    
    private var sectionsInfo: [MainPageContent] = [
        .init(name: "Топ фильмов", type: .topMovies),
        .init(name: "Последние фильмы", type: .lastMovies),
        .init(name: "Топ сериалов", type: .topSerials),
        .init(name: "Последние сериалы", type: .topSerials)
    ]
    
    var sectionsCount: Int {
        return sectionsInfo.count
    }
    
    func getSectionName(_ section: Int) -> String {
        return sectionsInfo[section].name
    }
    
    func loadSectionData(section: Int, success: @escaping ([ContentInfo]) -> Void, failure: @escaping (String) -> Void) {
        let type = MainPageContent.ContentListType(rawValue: section)
        let from = 0
        let count = 15
        
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
    
    func loadPreviewData(success: @escaping ([ContentInfo]) -> Void, failure: @escaping (String) -> Void) {
        contentInteractor.previewContent() { response in
            guard let body = response.body else {
                failure("Неизвестная ошибка")
                return
            }
            success(self.trasformate(content: body))
        } failure: { error in
            failure(error.localizedDescription)
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
