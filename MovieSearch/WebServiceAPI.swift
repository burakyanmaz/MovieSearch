//
//  WebServiceAPI.swift
//  MovieSearch
//
//  Created by NDSDEVTEAM9 on 21.09.2018.
//  Copyright © 2018 simpler. All rights reserved.
//

import UIKit

enum WebServiceAPI {
    enum MovieList {
        case search(withQuery: String, page: Int)
        
        var url: String {
            switch self {
            case .search(let query, let page):
                return "http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=\(query)&page=\(page)"
            }
        }
    }
    
    enum Poster {
        case poster(with: PosterKind, posterPath: String)
        
        var url: String {
            switch self {
            case .poster(let posterKind, let posterPath):
                return "http://image.tmdb.org/t/p/\(posterKind.rawValue)\(posterPath)"
            }
        }
    }
    
    enum PosterKind: String {
        case w92
        case w185
        case w500
        case w780
    }
}
