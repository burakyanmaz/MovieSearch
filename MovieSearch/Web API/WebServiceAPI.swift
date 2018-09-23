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
        
        static let scheme = "http"
        static let host = "api.themoviedb.org"
        static let path = "/3/search"
        
        enum Methods: String {
            
            case movie = "/movie"
            
        }
        
        enum Parameters {
            enum Keys: String {
                case api_key
                case query
                case page
            }
            
            enum Values: CustomStringConvertible {
                case appid
                case query(searchQuery: String)
                case pageNumber(Int)
                
                var description: String {
                    switch self {
                    case .appid:
                        return "2696829a81b1b5827d515ff121700838"
                    case .query(let searchQuery):
                        return searchQuery
                    case .pageNumber(let number):
                        return "\(number)"
                    }
                }
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
