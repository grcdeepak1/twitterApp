//
//  FavViewCell.swift
//  twitterApp
//
//  Created by Deepak on 9/28/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class FavViewCell: UITableViewCell {

    
    @IBOutlet var favButton: UIButton!
    
    @IBOutlet var retweetButton: UIButton!
    var tweet : Tweet! {
        willSet(tweet) {
            println("In Fav cell Favorited : \(tweet.favorited)")
            if(tweet.favorited == 0) {
                favButton.setImage(UIImage(named: "favorite.png"), forState: .Normal)
            } else {
                favButton.setImage(UIImage(named: "favorite_on.png"), forState: .Normal)
            }
            if(tweet.retweeted == true) {
                retweetButton.setImage(UIImage(named: "retweet_on.png"), forState: .Normal)
            } else {
                retweetButton.setImage(UIImage(named: "retweet.png"), forState: .Normal)
            }
            
            
            
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
