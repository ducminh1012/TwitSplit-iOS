//
//  Utilities.swift
//  TwitSplit-iOS
//
//  Created by MD on 7/10/18.
//  Copyright © 2018 MD. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAddTweetPopup(handler: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: "Add new tweet", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Enter your message"
        })
        
        let tweetAction = UIAlertAction(title: "Tweet", style: .default, handler: { alert -> Void in
            guard let text = alertController.textFields?.first?.text else { return }
            handler(text)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(tweetAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
}
