//
//  ProfileViewController.swift
//  twitterApp
//
//  Created by Deepak on 10/5/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,  MentionsViewDelegate {
    
    var tweets: [Tweet]?
    var user = User.currentUser?
    var current_user: User?
    var newUser: User?
    var refreshControl:UIRefreshControl!
    var containerVC: ContainerViewController!
    var mentionView: Bool?
    
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
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        containerVC = storyboard.instantiateViewControllerWithIdentifier("ContainerViewController") as ContainerViewController
        containerVC.delegate = self
        
        self.navigationController?.navigationBar.barTintColor = UIColorFromRGB(0x55ACEE)
        
        if (newUser != nil) {
                current_user = self.newUser
        } else {
                current_user = User.currentUser
        }
        // Do any additional setup after loading the view.
        profileName.text = current_user?.name
        profileScreenname.text = "@\((current_user?.screenname)!)"
        if let url = current_user?.profileImageUrl {
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
        if let BGurl = current_user?.profileBackgroundImageUrl {
            profileBGImage.setImageWithURL(NSURL(string: BGurl))
        }
        numTweets.text    = current_user?.numTweets?.stringValue
        numFollowers.text = current_user?.numFollowers?.stringValue
        numFollowing.text = current_user?.numFollowing?.stringValue
        
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
        //var params = [ "include_rts" : true , "trim_user" : false]
        var params: [String:String] = [String:String]()
        params["screen_name"] = current_user?.screenname
        if (self.mentionView == nil ) {
            TwitterClient.sharedInstance.userTimeLineWithParams(params, completion: {(tweets, error) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            })
        } else {
            println("calling mentionsWithParams")
            TwitterClient.sharedInstance.mentionsWithParams(params, completion: {(tweets, error) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            })
        }
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)

        
    }
    
    
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
    
    func MentionsViewRequested(value: Bool) -> Void {
        println("Inside MentionsViewRequested delegate")
        if(value == true) {
            self.mentionView = true
        }
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
