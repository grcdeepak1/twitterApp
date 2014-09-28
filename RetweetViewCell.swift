//
//  RetweetViewCell.swift
//  twitterApp
//
//  Created by Deepak on 9/28/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class RetweetViewCell: UITableViewCell {

    @IBOutlet var numRetweetsLabel: UILabel!
    
    var tweet : Tweet! {
        willSet(tweet) {
            numRetweetsLabel.text = "25"
            numFavLabel.text      = "32"
        }
    }
    
    @IBOutlet var numFavLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}