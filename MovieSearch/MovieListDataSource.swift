//
//  MovieListDataSource.swift
//  MovieSearch
//
//  Created by NDSDEVTEAM9 on 21.09.2018.
//  Copyright © 2018 simpler. All rights reserved.
//

import UIKit

// TODO: - Look for UITableViewDataSourcePrefetching for pagination (iOS 10.0+ though). -
// TODO: - Look into https://stackoverflow.com/a/35475282/4369441 for iOS 9.0.
class MovieListDataSource: NSObject {
    struct ListDataSource {
        var movieList: [MovieResult]?
    }
    
    fileprivate var movieData: MovieListWebResponse?
}

extension MovieListDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let theMovieData = movieData, let totalRecords = theMovieData.totalResults, let pageRows = theMovieData.results else {
            return 0
        }
        
        return totalRecords > 0 ? pageRows.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie info cell", for: indexPath) as! MovieTableViewCell
        
        cell.setMovieCell(with: <#T##MovieResult#>)
    }
}

extension MovieListDataSource: Observer {
    func searchHappened(with keywords: String) {
        // Make another search
        
    }
}
