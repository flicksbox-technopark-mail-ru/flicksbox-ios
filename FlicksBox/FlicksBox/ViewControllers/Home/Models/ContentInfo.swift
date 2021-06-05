//
//  ContentInfo.swift
//  FlicksBox
//
//  Created by Mac-HOME on 20.05.2021.
//

import Foundation

// TODO: uses in different places -> move to another place
final class ContentInfo: Equatable {
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
    let originalName: String
    let image: String
    let largeImage: String
    let year: Int
    let type: ContentType
    let description: String
    let shortDescription: String
    let video: String
    var liked: Bool?
    var favourite: Bool?
    
    convenience init(from movie: APIMovie) {
        self.init(
            id: movie.id,
            contentId: movie.content_id,
            name: movie.name,
            image: movie.images,
            year: movie.year,
            type: ContentType(apiType: movie.type),
            short_desc: movie.short_description,
            original_name: movie.original_name,
            favorite: movie.is_favourite,
            description: movie.description,
            liked: movie.is_liked
        )
    }
    
    convenience init(from tvShow: APITVShow) {
        self.init(
            id: tvShow.id,
            contentId: tvShow.content_id,
            name: tvShow.name,
            image: tvShow.images,
            year: tvShow.year,
            type: ContentType(apiType: tvShow.type),
            short_desc: tvShow.short_description,
            original_name: tvShow.original_name,
            favorite: tvShow.is_favourite,
            description: tvShow.description,
            liked: tvShow.is_liked
        )
    }
    
    init(id: Int, contentId: Int, name: String, image: String, year: Int, type: ContentType, short_desc: String, original_name: String, favorite: Bool?, description: String, liked: Bool?) {
        self.id = id
        self.contentId = contentId
        self.name = name
        self.originalName = original_name
        self.image = "https://www.flicksbox.ru\(image)/640"
        self.largeImage = "https://www.flicksbox.ru\(image)/1920"
        self.year = year
        self.type = type
        self.shortDescription = short_desc
        self.favourite = favorite
        self.description = description
        self.liked = liked
        
        if type == .movie {
            self.video = "https://www.flicksbox.ru/videos/\(contentId)/movie.mp4"
        } else {
            // first episode of a first season
            let trasformed_name = self.originalName.replacingOccurrences(of: " ", with: "", options: .literal, range: nil).lowercased()
            self.video = "https://www.flicksbox.ru/videos/\(trasformed_name)_\(contentId)/1/1.mp4"
        }
    }
    
    static func ==(lhs: ContentInfo, rhs: ContentInfo) -> Bool {
        return lhs.contentId == rhs.contentId
    }
}
