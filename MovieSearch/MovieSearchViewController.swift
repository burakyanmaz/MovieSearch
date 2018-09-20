//
//  ViewController.swift
//  MovieSearch
//
//  Created by Burak Yanmaz on 20.09.2018.
//  Copyright © 2018 simpler. All rights reserved.
//

import UIKit
import PYSearch

class MovieSearchViewController: UIViewController {

    var searchViewController: PYSearchViewController?
    let searchDelegate = MovieSearchDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchViewController = PYSearchViewController.init(hotSearches: [""], searchBarPlaceholder: "Search a movie...", didSearch: { (searchVC, searchBar, searchedText) in
//            searchVC?.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        })
        searchViewController?.showHotSearch = false
        searchViewController?.delegate = searchDelegate
        searchViewController?.searchHistoriesCount = 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        
        if let theSearchViewController = searchViewController {
            let nav = UINavigationController.init(rootViewController: theSearchViewController)
            present(nav, animated: false, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

