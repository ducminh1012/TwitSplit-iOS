//
//  Utilities.swift
//  TwitSplit-iOS
//
//  Created by MD on 7/10/18.
//  Copyright © 2018 MD. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAddTweetPopup(handler: @escaping (String) -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: "New Tweet (\(kMaxlength))", message: nil, preferredStyle: .alert)
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
        
        return alertController
    }
    
    func showError(message: String) -> Void {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
