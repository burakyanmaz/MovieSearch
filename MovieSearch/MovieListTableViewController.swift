//
//  ViewController.swift
//  MovieSearch
//
//  Created by Burak Yanmaz on 20.09.2018.
//  Copyright © 2018 simpler. All rights reserved.
//

import UIKit
import PYSearch

class MovieListTableViewController: UITableViewController {

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
        searchViewController?.searchHistoriesCount = 10
        searchViewController?.searchViewControllerShowMode = .modePush
        
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func searchMovieBarButtonAction(_ sender: UIBarButtonItem) {
        if let theSearchViewController = searchViewController {
            self.navigationController?.pushViewController(theSearchViewController, animated: true)
        }
    }
}

extension MovieListTableViewController: Observer {
    func searchResultFetched() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

