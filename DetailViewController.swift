//
//  DetailViewController.swift
//  twitterApp
//
//  Created by Deepak on 9/28/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    var tweet : Tweet!
    
    @IBOutlet var detTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detTableView.dataSource = self
        detTableView.delegate   = self
        detTableView.tableFooterView = UIView()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch (indexPath.row) {
            case 0 :
                //println(indexPath.row)
                var cell = tableView.dequeueReusableCellWithIdentifier("detailViewCell") as DetailViewCell
                println("Tweet ID:  Fav count : \(self.tweet.favorite_count)")
                cell.tweet = self.tweet
                return cell
            case 1:
                var cell = tableView.dequeueReusableCellWithIdentifier("retweeetViewCell") as RetweetViewCell
                //println(indexPath.row)
                cell.tweet = self.tweet
                return cell
            case 2:
            var cell = tableView.dequeueReusableCellWithIdentifier("favViewCell") as FavViewCell
            //println(indexPath.row)
            return cell
            default:
                println("error")
                println(indexPath.row)
                var cell = tableView.dequeueReusableCellWithIdentifier("detailViewCell") as DetailViewCell
                return cell
        }

    }
    
    
    @IBAction func onFavorite(sender: AnyObject) {
        TwitterClient.sharedInstance.favoriteWithID(self.tweet.id_str!, callback: {(error) -> () in
            if(error != nil) {
                println("Tweet id : \(self.tweet.id_str!) : Error on Favorite")
                TwitterClient.sharedInstance.unfavoriteWithID(self.tweet.id_str!, callback: {(error1) -> () in
                    if(error1 != nil) {
                        println("Tweet id : \(self.tweet.id_str!) : Error on Unfavorite")
                    } else {
                        //Increment the Favorite count in the current screen
                        self.tweet.favorite_count = self.tweet.favorite_count! - 1
                        println("Tweet id : \(self.tweet.id_str!) : Unfavorite of tweet succeeded")
                        self.detTableView.reloadData()
                    }
                })
            } else {
                //Increment the Favorite count in the current screen
                self.tweet.favorite_count = self.tweet.favorite_count! + 1
                println("Tweet id : \(self.tweet.id_str!) : Favorite of tweet succeeded")
                self.detTableView.reloadData()
            }
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
