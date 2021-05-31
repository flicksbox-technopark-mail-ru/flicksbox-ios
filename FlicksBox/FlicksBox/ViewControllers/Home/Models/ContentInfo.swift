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
    let original_name: String
    let image: String
    let large_image: String
    let year: Int
    let type: ContentType
    let short_desc: String
    let video: String
    
    init(from movie: APIMovie) {
        self.init(id: movie.id, contentId: movie.content_id, name: movie.name, image: movie.images, year: movie.year, type: ContentType(apiType: movie.type), short_desc: movie.short_description, original_name: movie.original_name)
    }
    
    init(from tvShow: APITVShow) {
        self.init(id: tvShow.id, contentId: tvShow.content_id, name: tvShow.name, image: tvShow.images, year: tvShow.year, type: ContentType(apiType: tvShow.type), short_desc: tvShow.short_description, original_name: tvShow.original_name)
    }
    
    init(id: Int, contentId: Int, name: String, image: String, year: Int, type: ContentType, short_desc: String, original_name: String) {
        self.id = id
        self.contentId = contentId
        self.name = name
        self.original_name = original_name
        self.image = "https://www.flicksbox.ru\(image)/640"
        self.large_image = "https://www.flicksbox.ru\(image)/1920"
        self.year = year
        self.type = type
        self.short_desc = short_desc
        
        // TODO move to helpers
        if type == .movie {
            self.video = "https://www.flicksbox.ru/videos/\(contentId)/movie.mp4"
        } else {
            // first episode of a first season
            let trasformed_name = self.original_name.replacingOccurrences(of: " ", with: "", options: .literal, range: nil).lowercased()
            self.video = "https://www.flicksbox.ru/videos/\(trasformed_name)_\(contentId)/1/1.mp4"
        }
    }
    
    static func ==(lhs: ContentInfo, rhs: ContentInfo) -> Bool {
        return lhs.contentId == rhs.contentId
    }
}
