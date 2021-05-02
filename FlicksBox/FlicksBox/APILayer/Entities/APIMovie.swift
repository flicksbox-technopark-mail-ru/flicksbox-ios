//
//  APIMovie.swift
//  FlicksBox
//
//  Created by sn.alekseev on 11.04.2021.
//

import Foundation

struct APIMovie: Decodable {
    let content_id: Int
    let description: String
    let id: Int
    let images: String
    let is_favourite: Bool
    let is_free: Bool
    let is_liked: Bool?
    let name: String
    let original_name: String
    let rating: Int
    let short_description: String
    let type: APIContentType
    let video: String
    let year: Int
}
