//
//  ConnectionService.swift
//  MovieSearch
//
//  Created by Burak Yanmaz on 23/09/2018.
//  Copyright © 2018 simpler. All rights reserved.
//

import UIKit

class ConnectionService: NSObject {
    func getMovieList<T: MovieListWebResponse> (forQuery query: WebServiceAPI.MovieList.Parameters.Values, forPage page: WebServiceAPI.MovieList.Parameters.Values, with type: T.Type, completion: @escaping (_ movieListData: T?) -> Void) {
        
        let parameters: [WebServiceAPI.MovieList.Parameters.Keys: WebServiceAPI.MovieList.Parameters.Values] = [.api_key: .appid,
                                                          .query: query,
                                                          .page: page
                                                          ]
        let connectionAPI = ConnectionAPI()
        connectionAPI.requestGET(method: WebServiceAPI.MovieList.Methods.movie, mappableObject: type, parameters: parameters) { (mappedObject, errorObject) in
            
            if let error = errorObject {
                
                // Already happening on main thread
                Alert.show(title: "Error", message: error.localizedDescription, okButton: "OK", retryButton: nil, completionHandler: { alertAction in
                    // After OK button is touched
                    completion(nil)
                })
                
                return
            }
            
            completion(mappedObject)
            
        }
    }
}
