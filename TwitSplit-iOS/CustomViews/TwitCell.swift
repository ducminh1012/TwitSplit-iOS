//
//  TwitCell.swift
//  TwitSplit-iOS
//
//  Created by MD on 7/10/18.
//  Copyright © 2018 MD. All rights reserved.
//

import UIKit

class TwitCell: UITableViewCell {
    static let identifier = "TwitCell"
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }

    func setupUI() {
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
        avatarImageView.clipsToBounds = true   
    }
    
    func setupData(tweet: Tweet) {
        avatarImageView.image = UIImage(named: "avatar.jpg")
        userNameLabel?.text = tweet.user
        messageLabel?.text = tweet.message
    }
}
