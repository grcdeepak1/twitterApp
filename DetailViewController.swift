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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
