//
//  Alert.swift
//  MovieSearch
//
//  Created by Burak Yanmaz on 23/09/2018.
//  Copyright © 2018 simpler. All rights reserved.
//

import UIKit

class Alert: NSObject {
    class func show(title: String, message: String, okButton: String, retryButton: String? = nil, completionHandler: ((UIAlertAction) -> Void)?){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let retryTitle = retryButton {
            let okAction = UIAlertAction(title: okButton, style: .default, handler: nil)
            let retryAction = UIAlertAction(title:retryTitle, style: .default, handler: completionHandler)
            ac.addAction(retryAction)
            ac.addAction(okAction)
        } else {
            let okAction = UIAlertAction(title: okButton, style: .default, handler: completionHandler)
            ac.addAction(okAction)
        }
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(ac, animated: true, completion: nil)
        }
    }
}
