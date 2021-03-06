//
//  MovieSearchDelegate.swift
//  MovieSearch
//
//  Created by Burak Yanmaz on 20.09.2018.
//  Copyright © 2018 simpler. All rights reserved.
//

import UIKit
import PYSearch

class MovieSearchDelegate: NSObject {
    
}

extension MovieSearchDelegate: PYSearchViewControllerDelegate {
    func searchViewController(_ searchViewController: PYSearchViewController!, didSearchWith searchBar: UISearchBar!, searchText: String!) {
        AppStateObserver.sharedInstance.startASearch(with: searchText)
        UIApplication.topViewController()?.navigationController?.popViewController(animated: true)
    }
    func searchViewController(_ searchViewController: PYSearchViewController!, didSelectSearchHistoryAt index: Int, searchText: String!) {
        AppStateObserver.sharedInstance.startASearch(with: searchText)
        UIApplication.topViewController()?.navigationController?.popViewController(animated: true)
    }
}
