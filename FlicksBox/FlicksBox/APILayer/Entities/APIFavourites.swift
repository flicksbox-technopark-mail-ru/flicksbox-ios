//
//  APIFavourites.swift
//  FlicksBox
//
//  Created by Mac-HOME on 30.05.2021.
//

import Foundation

struct APIFavourites: Decodable {
    let movies: [APIMovie]
    let tv_shows: [APITVShow]
}
