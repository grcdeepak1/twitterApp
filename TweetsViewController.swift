//
//  TweetsViewController.swift
//  twitterApp
//
//  Created by Deepak on 9/27/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetCellDelegate {
    
    var tweets: [Tweet]?
    var user = User.currentUser?
    var refreshControl:UIRefreshControl!

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120.0
        self.navigationController?.navigationBar.barTintColor = UIColorFromRGB(0x55ACEE)
        println("In Tweets ViewController : User : \(user?.name)")
        var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "loading .."
        hud.show(true)
        
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimeLineWithParams(nil, completion: {(tweets, error) -> () in
            self.tweets = tweets
            if (error != nil) {
                println(error)
            }
            self.tableView.reloadData()
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        })
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    override func viewDidAppear(animated: Bool) {
        /*
        TwitterClient.sharedInstance.homeTimeLineWithParams(nil, completion: {(tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        }) */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        var tweet = self.tweets?[indexPath.row]
        cell.delegate = self
        cell.tweet = tweet
        //cell.contentView.layoutSubviews()
        return cell
    }

    func refresh(refreshControl : UIRefreshControl)
    {
        var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "loading .."
        hud.show(true)
        
        // Code to refresh table view
        TwitterClient.sharedInstance.homeTimeLineWithParams(nil, completion: {(tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        })
        
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        self.view.endEditing(true)
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "detailSegue") {
            var nav = segue.destinationViewController as UINavigationController
            if nav.viewControllers[0] is DetailViewController {
                var detVc = nav.viewControllers[0] as DetailViewController
                let indexPath = self.tableView.indexPathForSelectedRow()?.row
                // pass data to next view
                //println("indexPath : \(indexPath)")
                detVc.tweet = self.tweets?[indexPath!]
            }
        } else if (segue.identifier == "newSegue") {
            var nav = segue.destinationViewController as UINavigationController
            if nav.viewControllers[0] is NewViewController {
                var newVc = nav.viewControllers[0] as NewViewController
                let indexPath = self.tableView.indexPathForSelectedRow()?.row
                // pass data to next view
                println("In Tweets Segue to newVc: user : \(user?.name)")
                newVc.user = self.user
            }
            
        } else if ( segue.identifier == "profileSegue") {
            var nav = segue.destinationViewController as UINavigationController
            if nav.viewControllers[0] is ProfileViewController {
                var newVc = nav.viewControllers[0] as ProfileViewController
                newVc.newUser = sender as? User
            }
        }
    }
    
    func TweetCellImageButton(user: User) {
        self.performSegueWithIdentifier("profileSegue", sender: user)
    }
}
