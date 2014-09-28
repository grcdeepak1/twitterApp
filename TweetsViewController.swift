//
//  TweetsViewController.swift
//  twitterApp
//
//  Created by Deepak on 9/27/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets: [Tweet]?
    var refreshControl:UIRefreshControl!

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate   = self
        
        var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "loading .."
        hud.show(true)
        
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimeLineWithParams(nil, completion: {(tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        })
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
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
        cell.tweet = tweet
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
                detVc.tweet = self.tweets?[indexPath!]
            }
        } else if (segue.identifier == "newSegue") {
            var nav = segue.destinationViewController as UINavigationController
            if nav.viewControllers[0] is NewViewController {
                var newVc = nav.viewControllers[0] as NewViewController
                let indexPath = self.tableView.indexPathForSelectedRow()?.row
                // pass data to next view
                newVc.tweet = self.tweets?[indexPath!]
            }
            
        }
    }


}