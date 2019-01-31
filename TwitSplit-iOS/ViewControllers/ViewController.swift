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
            
            self.buildTweets(message: message)
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

        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func addTweet(messages: [String]) {
        let tweets = messages.map { (m) -> Tweet in
            let tweet = Tweet(user: kUser, message: m, time: Date())
            return tweet
        }
        self.tweets.append(contentsOf: tweets)
        self.tableView.reloadData()
    }
    
    // Private function to build message to multiple tweets
    private func buildTweets(message: String) {
        do {
            let splitMessages = try splitMessage(message: message)
            self.addTweet(messages: splitMessages)
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

        addTweetPopup?.title = "New Tweet (\(newLength))"

        return true
    }
}
