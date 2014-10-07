//
//  ProfileViewController.swift
//  twitterApp
//
//  Created by Deepak on 10/5/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    var tweets: [Tweet]?
    var user = User.currentUser?
    var refreshControl:UIRefreshControl!
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var profileName: UILabel!
    @IBOutlet var profileScreenname: UILabel!
    @IBOutlet var profilePageControl: UIPageControl!
    @IBOutlet var profileHeaderView: UIView!
    @IBOutlet var profileBGImage: UIImageView!
    
    
    @IBOutlet var numTweets: UILabel!
    @IBOutlet var numFollowing: UILabel!
    @IBOutlet var numFollowers: UILabel!
    
    @IBOutlet var TweetsView: UIView!
    @IBOutlet var FollowingView: UIView!
    @IBOutlet var FollowersView: UIView!
    
    @IBOutlet var TweetsViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var FollowingViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var FollowersViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120.0
        self.navigationController?.navigationBar.barTintColor = UIColorFromRGB(0x55ACEE)
        // Do any additional setup after loading the view.
        profileName.text = User.currentUser?.name
        profileScreenname.text = "@\((User.currentUser?.screenname)!)"
        if let url = User.currentUser?.profileImageUrl {
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
        if let BGurl = User.currentUser?.profileBackgroundImageUrl {
            profileBGImage.setImageWithURL(NSURL(string: BGurl))
        }
        numTweets.text    = User.currentUser?.numTweets?.stringValue
        numFollowers.text = User.currentUser?.numFollowers?.stringValue
        numFollowing.text = User.currentUser?.numFollowing?.stringValue
        
        var boxWidth = profileHeaderView.frame.width/3
        TweetsViewWidthConstraint.constant = boxWidth as CGFloat
        FollowersViewWidthConstraint.constant = boxWidth as CGFloat
        FollowingViewWidthConstraint.constant = boxWidth as CGFloat
        TweetsView.backgroundColor = UIColorFromRGB(0xCCD6DD)
        FollowingView.backgroundColor = UIColorFromRGB(0x8899A6)
        FollowersView.backgroundColor = UIColorFromRGB(0x66757F)
        
        var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "loading .."
        hud.show(true)
        
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.userTimeLineWithParams(nil, completion: {(tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        })
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)

        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        var tweet = self.tweets?[indexPath.row]
        cell.tweet = tweet
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(refreshControl : UIRefreshControl)
    {
        var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "loading .."
        hud.show(true)
        
        // Code to refresh table view
        TwitterClient.sharedInstance.userTimeLineWithParams(nil, completion: {(tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
