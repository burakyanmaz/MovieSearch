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
    let tableViewDelegate = MovieListDelegate()
    let tableViewDataSource = MovieListDataSource()
    let emptySetDataSourceAndDelegate = EmptyDataSetDataSourceAndDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchViewController = PYSearchViewController.init(hotSearches: [""], searchBarPlaceholder: "Search a movie...")
        searchViewController?.showHotSearch = false
        searchViewController?.delegate = searchDelegate
        searchViewController?.searchHistoriesCount = 10
        searchViewController?.searchViewControllerShowMode = .modePush
        
        tableView.tableFooterView = UIView()
        
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        tableView.emptyDataSetSource = emptySetDataSourceAndDelegate
        tableView.emptyDataSetDelegate = emptySetDataSourceAndDelegate
        
        AppStateObserver.sharedInstance.addObserver(observer: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func searchMovieBarButtonAction(_ sender: UIBarButtonItem) {
        openSearchViewController()
    }
    
    fileprivate func openSearchViewController() {
        if let theSearchViewController = searchViewController {
            self.navigationController?.pushViewController(theSearchViewController, animated: true)
        }
    }
}

extension MovieListTableViewController: Observer {
    func newPageDidLoad(totalItemCount: Int, itemCountSoFar: Int) {
        // Update movieListCount
        DispatchQueue.main.async { [weak self] in
            self?.tableViewDelegate.setItemCounts(totalItemCount: totalItemCount, itemCountSoFar: itemCountSoFar)
            self?.tableView.reloadData()
            self?.tableViewDelegate.activityView?.stopAnimating()
            
            self?.title = self?.tableViewDataSource.movieData?.queryToSearch
        }
    }
    
    func shouldOpenSearchVC() {
        openSearchViewController()
    }
}

