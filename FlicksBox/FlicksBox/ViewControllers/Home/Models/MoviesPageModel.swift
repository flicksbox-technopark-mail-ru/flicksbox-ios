//
//  MoviesPageModel.swift
//  FlicksBox
//
//  Created by Mac-HOME on 20.05.2021.
//

import Foundation

struct MoviesPageContent: PageContent {
    let name: String
    let id: Int
}

final class MoviesPageModel: NSObject, PageModel {
    private let interactor = FilmsInteractor()
    
    var sectionsInfo: [MoviesPageContent] = [
        .init(name: "Боевики", id: 3),
        .init(name: "Триллеры", id: 5),
        .init(name: "Комедии", id: 1),
        .init(name: "Фэнтези", id: 9),
        .init(name: "Драмы", id: 2),
        .init(name: "Фантастика", id: 7)
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
        interactor.moviesByGenre(from: from, count: count, genre: sectionsInfo[section].id) { response in
            success(self.trasformate(movies: response.body?.movies ?? []))
        } failure: { error in
            failure(error.localizedDescription)
        }
    }
    
    func loadPreviewData(success: @escaping ([ContentInfo]) -> Void, failure: @escaping (String) -> Void) {
        interactor.previewMovies() { response in
            success(self.trasformateShuffled(movies: response.body?.movies ?? []))
        } failure: { error in
            failure(error.localizedDescription)
        }
    }
    
    private func trasformate(movies: [APIMovie]) -> [ContentInfo] {
        return movies.map { movie -> ContentInfo in
            ContentInfo(from: movie)
        }
    }
    
    private func trasformateShuffled(movies: [APIMovie]) -> [ContentInfo] {
        return movies.map { movie -> ContentInfo in
            ContentInfo(from: movie)
        }.shuffled()
    }
}
