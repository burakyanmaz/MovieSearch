//
//  MovieListDataSource.swift
//  MovieSearch
//
//  Created by Burak Yanmaz on 21.09.2018.
//  Copyright © 2018 simpler. All rights reserved.
//

import UIKit

// TODO: - Look for UITableViewDataSourcePrefetching for pagination (iOS 10.0+ though). -
class MovieListDataSource: NSObject {
    struct ListDataSource {
        var queryToSearch: String?
        private(set) var movieList: [MovieResult]?
        var lastMovieData: MovieListWebResponse? {
            didSet {
                // When a page loads, just append new results into movieList
                if let newResults = lastMovieData?.results {
                    if movieList == nil {
                        movieList = [MovieResult]()
                    }
                    movieList?.append(contentsOf: newResults)
                }
            }
        }
    }
    
    var movieData: ListDataSource?
    
    override init() {
        super.init()
        AppStateObserver.sharedInstance.addObserver(observer: self)
    }
}

extension MovieListDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let theMovieData = movieData, let pageRows = theMovieData.movieList else {
            return 0
        }
        
        return pageRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie info cell", for: indexPath) as! MovieTableViewCell
        
        if let movieResult = movieData?.movieList?[indexPath.row] {
            cell.setMovieCell(with: movieResult)
        }
        
        return cell
    }
}

extension MovieListDataSource: Observer {
    func searchHappened(with keywords: String) {
        // A new search happened, so dealloc the previous one
        movieData = nil
        
        // Save the query for next page requests
        movieData = ListDataSource()
        movieData?.queryToSearch = keywords
        
        // Make a search for the first page
        makeASearch(keywords: keywords, pageNumber: 1)
    }
    
    func shouldLoadNewPage() {
        if let query = movieData?.queryToSearch, let currentPageNumber = movieData?.lastMovieData?.page {
            // Make a new request for the next page
            makeASearch(keywords: query, pageNumber: currentPageNumber + 1)
        }
    }
    
    private func makeASearch(keywords: String, pageNumber: Int) {
        // Make a search
        let connectionService = ConnectionService()
        connectionService.getMovieList(forQuery: .query(searchQuery: keywords), forPage: .pageNumber(pageNumber), with: MovieListWebResponse.self) { [weak self] (movieListData) in
            
            if let theMovieListData = movieListData, let totalItemCount = theMovieListData.totalResults {
                self?.movieData?.lastMovieData = theMovieListData
                
                // After appending new moview into the movieList, get the count
                if let itemCountSoFar = self?.movieData?.movieList?.count {
                    AppStateObserver.sharedInstance.searchDidComplete(totalItemCount: totalItemCount, itemCountSoFar: itemCountSoFar)
                }
            }
        }
    }
}
