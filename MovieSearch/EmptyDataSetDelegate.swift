//
//  EmptyDataSetDelegate.swift
//  MovieSearch
//
//  Created by Burak Yanmaz on 23/09/2018.
//  Copyright © 2018 simpler. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class EmptyDataSetDataSourceAndDelegate: NSObject {

}

extension EmptyDataSetDataSourceAndDelegate: DZNEmptyDataSetSource {
//    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
//        switch contactPermission {
//        case .allowed:
//            return #imageLiteral(resourceName: "ic_contacts")
//        case .denied:
//            return #imageLiteral(resourceName: "Edit_Profile")
//        }
//    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "No movies to show")
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "To make a movie search tap below or top right button.")
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        return NSAttributedString(string: "Make a search")
    }
}

extension EmptyDataSetDataSourceAndDelegate: DZNEmptyDataSetDelegate {
    // The same delegate tap method for 2 kinds of situations (Permission denied & No contacts)
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        AppStateObserver.sharedInstance.openSearchViewController()
    }
}
