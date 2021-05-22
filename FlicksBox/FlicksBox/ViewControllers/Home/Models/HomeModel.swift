//
//  MainPageModel.swift
//  FlicksBox
//
//  Created by sn.alekseev on 11.04.2021.
//

import Foundation

protocol PageContent {
    var name: String { get }
}

protocol PageModel: NSObject {
    var sectionsCount: Int { get }
    func getSectionName(_ section: Int) -> String
    func loadSectionData(section: Int, success: @escaping ([ContentInfo]) -> Void, failure: @escaping (String) -> Void)
    func loadPreviewData(success: @escaping ([ContentInfo]) -> Void, failure: @escaping (String) -> Void)
}

struct Page {
    enum PageType: Int {
        case Main = 0
        case Movies
        case TVShows
        case MyList
    }
    
    let name: String
    let type: PageType
    let model: PageModel
}

final class HomeModel: NSObject {
    let pages: [Page] = [
        .init(name: "Главная", type: .Main, model: MainPageModel()),
        .init(name: "Фильмы", type: .Movies, model: MoviesPageModel()),
        .init(name: "Сериалы", type: .TVShows, model: TVShowsPageModel()),
        .init(name: "Мой список", type: .MyList, model: TVShowsPageModel()),
    ]
    
    func getPageModel(page: Page.PageType) -> PageModel {
        return pages[page.rawValue].model
    }
}
