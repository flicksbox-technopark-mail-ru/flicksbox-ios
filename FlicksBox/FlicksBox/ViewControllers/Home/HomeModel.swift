//
//  HomeModel.swift
//  FlicksBox
//
//  Created by sn.alekseev on 11.04.2021.
//

import Foundation

struct FilmsListInfo {
    let name: String
}

final class HomeModel: NSObject {
    private let interactor = FilmsInteractor()
    
    let sectionsInfo: [FilmsListInfo] = [
        .init(name: "Топ фильмов"),
        .init(name: "Последние фильмы"),
        .init(name: "Топ сериалов"),
        .init(name: "Последние сериалы")
    ]
    
    var countSections: Int {
        return sectionsInfo.count
    }
}
