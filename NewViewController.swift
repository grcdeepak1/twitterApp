//
//  NewViewController.swift
//  twitterApp
//
//  Created by Deepak on 9/28/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {
    var tweet : Tweet!
    var user: User!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var handleLabel: UILabel!
    
    @IBOutlet var tweetTextView: UITextView!
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = User.currentUser?.name
        // Do any additional setup after loading the view.
        println("In NewViewController : user :\(self.user?.name)")
        println("In NewViewController Current User from class : \(User.currentUser?.name)")
        if let author_name = tweet?.user?.screenname {
            tweetTextView.text = "@\(author_name) "
        }
        tweetTextView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onTweet(sender: AnyObject) {
        if (self.tweetTextView.text != "" ) {
            TwitterClient.sharedInstance.tweet(self.tweetTextView.text, callback: {(response, error) -> () in
                if(error != nil) {
                    println("Error on Posting Tweet")
                    println(error)
                } else {
                    println(response)
                    println("Tweet succeeded")
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            })
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
