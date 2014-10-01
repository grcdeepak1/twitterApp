//
//  DetailViewCell.swift
//  twitterApp
//
//  Created by Deepak on 9/28/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class DetailViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var tweetLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var screennameLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    
    var tweet : Tweet! {
        willSet(tweet) {
            nameLabel.text       = tweet?.user?.name
            tweetLabel.text      = tweet?.text
            timeLabel.text       = tweet?.createdAtString!
            screennameLabel.text = "@\((tweet?.user?.screenname)!)"
            
            if let url = tweet?.user?.profileImageUrl {
                //profileImage.setImageWithURL(NSURL(string: url))
                var request = NSURLRequest(URL: NSURL(string: url))
                profileImage.setImageWithURLRequest(request, placeholderImage: nil ,
                    success: { (request, response, image) -> Void in
                        //println(response)
                        self.profileImage.image = image
                        var layer = self.profileImage.layer as CALayer
                        layer.cornerRadius = 8.0
                        layer.masksToBounds = true
                    }, failure: { (request, response, error) -> Void in
                        println(error)
                })
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
