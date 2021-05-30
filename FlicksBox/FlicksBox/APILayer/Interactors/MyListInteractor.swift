//
//  MyListInteractor.swift
//  FlicksBox
//
//  Created by Mac-HOME on 30.05.2021.
//

import Foundation
import Hermes

struct FavouritesResponse: Decodable {
    let favourites: APIFavourites
}

final class MyListInteractor {
    private let client: HermesClient
    private let encoder: JSONEncoder
    
    init() {
        client = HermesClient(with: "https://www.flicksbox.ru/api/v1")
        encoder = JSONEncoder()
    }
    
    func content(
        success: @escaping (APIResponse<FavouritesResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        let request = HermesRequest(method: .get, path: "/favourites")
        request.successHandler = { response in
            guard let data = response.data.decode(type: APIResponse<FavouritesResponse>.self) else {
                failure(InteractorError.emptyData)
                return
            }
            success(data)
        }
        request.errorHandler = { error in
            failure(error)
        }
        client.run(with: request)
    }
}
