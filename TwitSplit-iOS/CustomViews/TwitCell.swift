//
//  TwitCell.swift
//  TwitSplit-iOS
//
//  Created by MD on 7/10/18.
//  Copyright © 2018 MD. All rights reserved.
//

import UIKit

class TwitCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    // MARK: Cell lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        setupUI()
    }

    // MARK: Private functions
    private func setupUI() {
        
        // Make avatar circle frame
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
    }
    
    // MARK: Internal function
    func setupData(tweet: Tweet) {
        avatarImageView.image = UIImage(named: "avatar.jpg")
        userNameLabel.text = tweet.user
        messageLabel.text = tweet.message
        timeLabel.text = tweet.time.toString()
    }
}
