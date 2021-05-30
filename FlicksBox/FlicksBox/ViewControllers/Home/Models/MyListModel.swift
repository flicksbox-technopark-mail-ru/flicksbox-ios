//
//  MyListModel.swift
//  FlicksBox
//
//  Created by Mac-HOME on 22.05.2021.
//

import Foundation

class MyListModel: NSObject, BaseHomeModel {
    private let interactor = MyListInteractor()
    
    func loadData(success: @escaping ([ContentInfo]) -> Void, failure: @escaping (String) -> Void) {
        interactor.content() { response in
            guard let body = response.body else {
                failure("Неизвестная ошибка")
                return
            }
            success(self.trasformate(resp: body))
        } failure: { error in
            print(error)
            failure(error.localizedDescription)
        }
    }
    
    private func trasformate(resp: FavouritesResponse) -> [ContentInfo] {
        let movies = resp.favourites.movies.map { movie -> ContentInfo in
            ContentInfo(from: movie)
        }
        let tvshows = resp.favourites.tv_shows.map { tvshow -> ContentInfo in
            ContentInfo(from: tvshow)
        }
        return movies + tvshows
    }
}
