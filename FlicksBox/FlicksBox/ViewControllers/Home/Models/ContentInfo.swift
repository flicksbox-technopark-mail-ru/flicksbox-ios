//
//  ContentInfo.swift
//  FlicksBox
//
//  Created by Mac-HOME on 20.05.2021.
//

import Foundation

// TODO: uses in different places -> move to another place
struct ContentInfo: Equatable {
    enum ContentType {
        case movie
        case tvshow
        
        init(apiType: APIContentType) {
            switch apiType {
            case .movie:
                self = .movie
            case .tvshow:
                self = .tvshow
            }
        }
    }
    
    let id: Int
    let contentId: Int
    let name: String
    let image: String
    let large_image: String
    let year: Int
    let type: ContentType
    let short_desc: String
    
    init(from movie: APIMovie) {
        self.init(id: movie.id, contentId: movie.content_id, name: movie.name, image: movie.images, year: movie.year, type: ContentType(apiType: movie.type), short_desc: movie.short_description)
    }
    
    init(from tvShow: APITVShow) {
        self.init(id: tvShow.id, contentId: tvShow.content_id, name: tvShow.name, image: tvShow.images, year: tvShow.year, type: ContentType(apiType: tvShow.type), short_desc: tvShow.short_description)
    }
    
    init(id: Int, contentId: Int, name: String, image: String, year: Int, type: ContentType, short_desc: String) {
        self.id = id
        self.contentId = contentId
        self.name = name
        self.image = "https://www.flicksbox.ru\(image)/640"
        self.large_image = "https://www.flicksbox.ru\(image)/1920"
        self.year = year
        self.type = type
        self.short_desc = short_desc
    }
    
    static func ==(lhs: ContentInfo, rhs: ContentInfo) -> Bool {
        return lhs.contentId == rhs.contentId
    }
}
