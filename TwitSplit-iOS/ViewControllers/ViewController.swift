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
        
        // Create new popup with message callback
        addTweetPopup = showAddTweetPopup { (message) in
            
            self.buildTweets(message: message)
        }
        
        // Add the delegate to handle new characters event
        addTweetPopup?.textFields?.first?.delegate = self
    }
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var tweets = [Tweet]()
    var addTweetPopup: UIAlertController?
    
    // MARK: ViewController lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    // MARK: Private functions
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func addTweet(messages: [String]) {
        
        // Convert literal messages string -> Tweet objects
        let tweets = messages.map { (m) -> Tweet in
            let tweet = Tweet(user: kUser, message: m, time: Date())
            return tweet
        }
        self.tweets.append(contentsOf: tweets)
    }
    
    // Private function to build message to multiple tweets
    private func buildTweets(message: String) {
        do {
            let splitMessages = try splitMessage(message: message)
            self.addTweet(messages: splitMessages)
            self.tableView.reloadData()
        } catch SplitError.inputError(let inputError) { // Catch input error
            showError(message: inputError)
        } catch (let unknownError) { // Catch anything else
            showError(message: unknownError.localizedDescription)
        }
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    // Set up for auto height table view cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TwitCell.identifier) as? TwitCell else { fatalError("Can not dequeue cell with identifier \(TwitCell.identifier)") }
        let tweet = tweets[indexPath.row]
        cell.setupData(tweet: tweet)
        return cell
    }
}

// MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        // Calculate length of the message
        let length = text.count + string.count - range.length

        // Update popup title after insert new characters
        addTweetPopup?.title = "New Tweet (\(length))"

        return true
    }
}
