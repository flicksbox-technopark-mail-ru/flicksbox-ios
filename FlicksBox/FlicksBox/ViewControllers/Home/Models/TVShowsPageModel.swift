//
//  TVShowsPageModel.swift
//  FlicksBox
//
//  Created by Mac-HOME on 20.05.2021.
//

import Foundation

struct TVShowsPageContent: PageContent {
    let name: String
    let id: Int
}

final class TVShowsPageModel: NSObject, PageModel {
    private let interactor = FilmsInteractor()
    
    var sectionsInfo: [TVShowsPageContent] = [
        .init(name: "Комедии", id: 1),
        .init(name: "Драмы", id: 2),
        .init(name: "Вестерны", id: 10),
        .init(name: "Фантастика", id: 7),
        .init(name: "Анимация", id: 14),
    ]
    
    var sectionsCount: Int {
        return sectionsInfo.count
    }
    
    func getSectionName(_ section: Int) -> String {
        return sectionsInfo[section].name
    }
    
    func loadSectionData(section: Int, success: @escaping ([ContentInfo]) -> Void, failure: @escaping (String) -> Void) {
        let from = 0
        let count = 15
        interactor.tvshowsByGenre(from: from, count: count, genre: sectionsInfo[section].id) { response in
            success(self.trasformate(movies: response.body?.tvshows ?? []))
        } failure: { error in
            failure(error.localizedDescription)
        }
    }
    
    func loadPreviewData(success: @escaping ([ContentInfo]) -> Void, failure: @escaping (String) -> Void) {
        interactor.previewTVShows() { response in
            success(self.trasformateShuffled(movies: response.body?.tvshows ?? []))
        } failure: { error in
            failure(error.localizedDescription)
        }
    }
    
    private func trasformate(movies: [APITVShow]) -> [ContentInfo] {
        movies.map { movie -> ContentInfo in
            ContentInfo(from: movie)
        }
    }
    
    private func trasformateShuffled(movies: [APITVShow]) -> [ContentInfo] {
        movies.map { movie -> ContentInfo in
            ContentInfo(from: movie)
        }.shuffled()
    }
}
