//
//  MovieListWebResponse.swift
//  MovieSearch
//
//  Created by Burak Yanmaz on 21.09.2018.
//  Copyright © 2018 simpler. All rights reserved.
//

import UIKit
import ObjectMapper

class MovieListWebResponse : NSObject, NSCoding, Mappable {
    
    var page : Int?
    var results : [MovieResult]?
    var totalPages : Int?
    var totalResults : Int?
    
    
    class func newInstance(map: Map) -> Mappable? {
        return MovieListWebResponse()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map) {
        page <- map["page"]
        results <- map["results"]
        totalPages <- map["total_pages"]
        totalResults <- map["total_results"]
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder) {
        page = aDecoder.decodeObject(forKey: "page") as? Int
        results = aDecoder.decodeObject(forKey: "results") as? [MovieResult]
        totalPages = aDecoder.decodeObject(forKey: "total_pages") as? Int
        totalResults = aDecoder.decodeObject(forKey: "total_results") as? Int
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder) {
        if page != nil {
            aCoder.encode(page, forKey: "page")
        }
        if results != nil {
            aCoder.encode(results, forKey: "results")
        }
        if totalPages != nil {
            aCoder.encode(totalPages, forKey: "total_pages")
        }
        if totalResults != nil {
            aCoder.encode(totalResults, forKey: "total_results")
        }
    }
}

class MovieResult : NSObject, NSCoding, Mappable {
    
    var adult : Bool?
    var backdropPath : String?
    var genreIds : [Int]?
    var id : Int?
    var originalLanguage : String?
    var originalTitle : String?
    var overview : String?
    var popularity : Float?
    var posterPath : String?
    var releaseDate : String?
    var title : String?
    var video : Bool?
    var voteAverage : Float?
    var voteCount : Int?
    
    
    class func newInstance(map: Map) -> Mappable? {
        return MovieResult()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map) {
        adult <- map["adult"]
        backdropPath <- map["backdrop_path"]
        genreIds <- map["genre_ids"]
        id <- map["id"]
        originalLanguage <- map["original_language"]
        originalTitle <- map["original_title"]
        overview <- map["overview"]
        popularity <- map["popularity"]
        posterPath <- map["poster_path"]
        releaseDate <- map["release_date"]
        title <- map["title"]
        video <- map["video"]
        voteAverage <- map["vote_average"]
        voteCount <- map["vote_count"]
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder) {
        adult = aDecoder.decodeObject(forKey: "adult") as? Bool
        backdropPath = aDecoder.decodeObject(forKey: "backdrop_path") as? String
        genreIds = aDecoder.decodeObject(forKey: "genre_ids") as? [Int]
        id = aDecoder.decodeObject(forKey: "id") as? Int
        originalLanguage = aDecoder.decodeObject(forKey: "original_language") as? String
        originalTitle = aDecoder.decodeObject(forKey: "original_title") as? String
        overview = aDecoder.decodeObject(forKey: "overview") as? String
        popularity = aDecoder.decodeObject(forKey: "popularity") as? Float
        posterPath = aDecoder.decodeObject(forKey: "poster_path") as? String
        releaseDate = aDecoder.decodeObject(forKey: "release_date") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        video = aDecoder.decodeObject(forKey: "video") as? Bool
        voteAverage = aDecoder.decodeObject(forKey: "vote_average") as? Float
        voteCount = aDecoder.decodeObject(forKey: "vote_count") as? Int
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder) {
        if adult != nil {
            aCoder.encode(adult, forKey: "adult")
        }
        if backdropPath != nil {
            aCoder.encode(backdropPath, forKey: "backdrop_path")
        }
        if genreIds != nil {
            aCoder.encode(genreIds, forKey: "genre_ids")
        }
        if id != nil {
            aCoder.encode(id, forKey: "id")
        }
        if originalLanguage != nil {
            aCoder.encode(originalLanguage, forKey: "original_language")
        }
        if originalTitle != nil {
            aCoder.encode(originalTitle, forKey: "original_title")
        }
        if overview != nil {
            aCoder.encode(overview, forKey: "overview")
        }
        if popularity != nil {
            aCoder.encode(popularity, forKey: "popularity")
        }
        if posterPath != nil {
            aCoder.encode(posterPath, forKey: "poster_path")
        }
        if releaseDate != nil {
            aCoder.encode(releaseDate, forKey: "release_date")
        }
        if title != nil {
            aCoder.encode(title, forKey: "title")
        }
        if video != nil {
            aCoder.encode(video, forKey: "video")
        }
        if voteAverage != nil {
            aCoder.encode(voteAverage, forKey: "vote_average")
        }
        if voteCount != nil {
            aCoder.encode(voteCount, forKey: "vote_count")
        }
    }
}

