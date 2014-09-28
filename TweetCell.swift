//
//  TweetCell.swift
//  twitterApp
//
//  Created by Deepak on 9/28/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {


    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var tweetLabel: UILabel!
    @IBOutlet var timeAgoLabel: UILabel!
    
    var tweet : Tweet! {
        willSet(tweet) {
            nameLabel.text      = tweet?.user?.name
            tweetLabel.text     = tweet?.text
            timeAgoLabel.text   = tweet?.createdAt?.prettyTimestampSinceNow()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
