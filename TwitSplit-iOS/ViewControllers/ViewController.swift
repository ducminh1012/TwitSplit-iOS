//
//  ViewController.swift
//  TwitSplit-iOS
//
//  Created by MD on 7/10/18.
//  Copyright © 2018 MD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Actions
    @IBAction func onAddMessageButton(_ sender: UIBarButtonItem) {
        showAddTweetPopup { (message) in
            let tweet = Tweet(user: "Minh Duc", message: message)
            self.addTweet(tweet: tweet)
            self.tableView.reloadData()
        }
    }
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Properties
    var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addTweet(tweet: Tweet) {
        tweets.append(tweet)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TwitCell.identifier) as? TwitCell else { fatalError() }
        let tweet = tweets[indexPath.row]
        cell.setupData(tweet: tweet)
        return cell
    }
}
