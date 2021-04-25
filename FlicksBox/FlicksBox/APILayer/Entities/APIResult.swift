//
//  APIResult.swift
//  FlicksBox
//
//  Created by Mac-HOME on 25.04.2021.
//

import Foundation

struct APIResult: Decodable {
    let movies: [APIMovie]
    let tv_shows: [APITVShow]
    let actors: [APIActor]
}
