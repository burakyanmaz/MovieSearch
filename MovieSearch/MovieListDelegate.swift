//
//  MovieListDelegate.swift
//  MovieSearch
//
//  Created by Burak Yanmaz on 21.09.2018.
//  Copyright © 2018 simpler. All rights reserved.
//

import UIKit

class MovieListDelegate: NSObject {
    fileprivate var totalItemCount = 0
    fileprivate var itemCountSoFar = 0
    var activityView: UIActivityIndicatorView?
    
    override init() {
        super.init()
        
        AppStateObserver.sharedInstance.addObserver(observer: self)
    }
    
    func setItemCounts(totalItemCount: Int, itemCountSoFar: Int) {
        self.totalItemCount = totalItemCount
        self.itemCountSoFar = itemCountSoFar
    }
}

extension MovieListDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let theCell = cell as? MovieTableViewCell {
            // If the poster is still downloading, stop it as no cell is displayed
            theCell.stopLoadingThePoster()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == itemCountSoFar - 1 { // Last cell, so load the next page if there are more records to show.
            if totalItemCount > itemCountSoFar {
                AppStateObserver.sharedInstance.loadNextPage()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView.init()
        footerView.backgroundColor = UIColor.clear
        
        // Place the activity indicator view
        if activityView == nil {
            activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        }
        
        footerView.addSubview(activityView!)
        activityView?.hidesWhenStopped = true
        
        activityView?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
            item: activityView!,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: footerView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0
            ).isActive = true
        
        NSLayoutConstraint(
            item: activityView!,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: footerView,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0.0
            ).isActive = true
        
        return footerView
    }
}

extension MovieListDelegate: Observer {
    func searchHappened(with keywords: String) {
        DispatchQueue.main.async { [weak self] in
            self?.activityView?.startAnimating()
        }
    }
    
    func shouldLoadNewPage() {
        DispatchQueue.main.async { [weak self] in
            self?.activityView?.startAnimating()
        }
    }
}
