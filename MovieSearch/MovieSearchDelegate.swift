//
//  MovieSearchDelegate.swift
//  MovieSearch
//
//  Created by NDSDEVTEAM9 on 20.09.2018.
//  Copyright © 2018 simpler. All rights reserved.
//

import UIKit
import PYSearch

class MovieSearchDelegate: NSObject {
    
}

extension MovieSearchDelegate: PYSearchViewControllerDelegate {
    func searchViewController(_ searchViewController: PYSearchViewController!, searchTextDidChange searchBar: UISearchBar!, searchText: String!) {
        AppStateObserver.sharedInstance.startASearch(with: searchText)
    }
}
