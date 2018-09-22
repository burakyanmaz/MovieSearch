//
//  MovieListDelegate.swift
//  MovieSearch
//
//  Created by NDSDEVTEAM9 on 21.09.2018.
//  Copyright © 2018 simpler. All rights reserved.
//

import UIKit

class MovieListDelegate: NSObject {
    fileprivate var totalItemCount = 0
    fileprivate var itemCountSoFar = 0
    
    func setItemCounts(totalItemCount: Int, itemCountSoFar: Int) {
        self.totalItemCount = totalItemCount
        self.itemCountSoFar = itemCountSoFar
    }
}

extension MovieListDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let theCell = cell as? MovieTableViewCell {
            // If the poster is still downloading, stop it as no cell is displayed
            theCell.stopLoadingThePoster()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == itemCountSoFar - 1 { // Last cell
            if totalItemCount > itemCountSoFar {
                loadMoreItems()
            }
        }
    }
}
