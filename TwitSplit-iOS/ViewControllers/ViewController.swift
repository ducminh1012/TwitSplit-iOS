//
//  ViewController.swift
//  TwitSplit-iOS
//
//  Created by MD on 7/10/18.
//  Copyright © 2018 MD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Actions
    @IBAction func onAddMessageButton(_ sender: UIBarButtonItem) {
        addTweetPopup = showAddTweetPopup { (message) in
            
            let needToSplit = self.checkToSplit(message: message)
            
            if (needToSplit) {
                let splitMessages = self.splitMessage(message: message)
                
                splitMessages.forEach({ (message) in
                    self.addTweet(message: message)
                })
            } else {
                self.addTweet(message: message)
            }
        }
        
        addTweetPopup?.textFields?.first?.delegate = self
    }
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var tweets = [Tweet]()
    var addTweetPopup: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func addTweet(message: String) {
        let tweet = Tweet(user: kUser, message: message, time: Date())
        tweets.append(tweet)
        self.tableView.reloadData()
    }
    
    private func checkToSplit(message: String) -> Bool {
        return message.count > kMaxlength
    }
    
    private func splitMessage(message: String) -> [String] {
        var result = [String]()
        if (checkWordLength(message: message)) { // Check invalid words
            extractWords(message: message, result: &result)
            
        } else {
            showError(message: "Message contains word with over \(kMaxlength) characters")
        }
        print("result", result)
        
        return result
    }
    
    // Loop through message to extract words by length
    private func extractWords(message: String, result: inout [String]) {
        var id = 1
        
        var words = message.components(separatedBy: " ")
        
        if (message.count <= kMaxlength - kPartIndicatorLength) {
            result.append(message)
        } else {
            
            while (id < words.count) {
                id += 1
                
                let a = words[0..<id].joined(separator: " ")
                
                if (a.count > kMaxlength - kPartIndicatorLength) {
                    let mm = id - 1
                    result.append(words[0..<mm].joined(separator: " "))
                    words = Array(words[mm...])
                    
                    break
                }
                
            }
            let nextStr = words.joined(separator: " ")
            extractWords(message: nextStr, result: &result)
        }
        
    }
    
    private func checkWordLength(message: String) -> Bool {
        let words = message.components(separatedBy: " ")
        
        for word in words {
            if (word.count > kMaxlength) {
                return false
            }
        }
        
        return true
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TwitCell.identifier) as? TwitCell else { fatalError() }
        let tweet = tweets[indexPath.row]
        cell.setupData(tweet: tweet)
        return cell
    }
}

// MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        
        if (newLength <= kMaxlength) {
            addTweetPopup?.title = "New Tweet (\(kMaxlength - newLength))"
        } else {
            let partCount = newLength / kMaxlength + 1
            addTweetPopup?.title = "New Tweet (\(partCount)/\(partCount))"
        }
        return true
    }
}
