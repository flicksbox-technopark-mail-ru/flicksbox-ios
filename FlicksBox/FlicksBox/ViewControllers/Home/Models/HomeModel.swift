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

protocol BaseHomeModel: NSObject {}

protocol PageModel: BaseHomeModel {
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
    let model: BaseHomeModel
}

final class HomeModel: NSObject {
    private let pages: [Page] = [
        .init(name: "Главная", type: .Main, model: MainPageModel()),
        .init(name: "Фильмы", type: .Movies, model: MoviesPageModel()),
        .init(name: "Сериалы", type: .TVShows, model: TVShowsPageModel()),
        .init(name: "Мой список", type: .MyList, model: MyListModel()),
    ]
    
    var activePages: [Page] {
        get {
            var activePages = pages
            if ClientUser.shared.userData == nil {
                // delete my list page from pages
                // how do better
                activePages.removeLast()
            }
            return activePages
        }
    }
    
    // ClientUser.shared.userData
    // TODO
    // как скрыть при неавторизованом
    // и как открыть при авторизованном
    // возможно let hide: Bool в struct Page
    
    
    func getPageModel(page: Page.PageType) -> BaseHomeModel {
        return pages[page.rawValue].model
    }
}
