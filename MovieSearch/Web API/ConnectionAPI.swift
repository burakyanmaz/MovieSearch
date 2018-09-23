//
//  ConnectionAPI.swift
//  MovieSearch
//
//  Created by Burak Yanmaz on 22/09/2018.
//  Copyright © 2018 simpler. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ConnectionAPI: NSObject {
    func requestGET<T: Mappable> (method: WebServiceAPI.MovieList.Methods, mappableObject: T.Type, parameters: [WebServiceAPI.MovieList.Parameters.Keys: WebServiceAPI.MovieList.Parameters.Values], completionHandler: @escaping (_ object: T?, _ error: Error?) -> Void) {
        let url = urlFor(parameters: parameters, method: method)
        print(url)
        
        
        Alamofire.request(url.absoluteString, method: .get, parameters: nil, encoding: JSONEncoding.default)
            
            .responseJSON(completionHandler: { (json) in
                print(json)
            })
            
            .responseObject { (response: DataResponse<T>) in
                
                
                switch response.result{
                case .success(let value):
                    completionHandler(value, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
            }
            .responseString { (response) in
                print(response)
            }
    }
    
    func urlFor(parameters: [WebServiceAPI.MovieList.Parameters.Keys: WebServiceAPI.MovieList.Parameters.Values], method: WebServiceAPI.MovieList.Methods? = nil) -> URL {
        
        var components = URLComponents()
        components.path = WebServiceAPI.MovieList.path + (method?.rawValue ?? "")
        components.scheme = WebServiceAPI.MovieList.scheme
        components.host = WebServiceAPI.MovieList.host
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let item = URLQueryItem(name: key.rawValue, value: "\(value.description)")
            components.queryItems?.append(item)
        }
        return components.url!
    }
}
