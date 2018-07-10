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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupData(tweet: Tweet) {
        textLabel?.text = tweet.user
        detailTextLabel?.text = tweet.message
    }
}
