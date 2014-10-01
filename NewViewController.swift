//
//  NewViewController.swift
//  twitterApp
//
//  Created by Deepak on 9/28/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class NewViewController: UIViewController, UITextViewDelegate {
    var tweet : Tweet!
    var user: User!
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var handleLabel: UILabel!
    
    @IBOutlet var tweetTextView: UITextView!
    
    var countLabel: UILabel!
    
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColorFromRGB(0xF5F8FA)
        nameLabel.text = User.currentUser?.name
        handleLabel.text = User.currentUser?.screenname
        if let url = User.currentUser?.profileImageUrl {
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
        
        // Do any additional setup after loading the view.
        println("In NewViewController : user :\(self.user?.name)")
        println("In NewViewController Current User from class : \(User.currentUser?.name)")
        if let author_name = tweet?.user?.screenname {
            tweetTextView.text = "@\(author_name) "
        }
        tweetTextView.delegate = self
        
        var navbar = navigationController?.navigationBar
        countLabel = UILabel(frame: CGRectMake(280, 16, 40, 30))
        countLabel.font = UIFont(name: "Helvetica", size: 12)
        countLabel.text = "140"
        countLabel.sizeToFit()
        navbar?.addSubview(countLabel)
        
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
                    UIAlertView(
                        title: "Error",
                        message: "Your tweet could not be sent. Please try again later.",
                        delegate: self,
                        cancelButtonTitle: "Dismiss").show()
                } else {
                    println(response)
                    println("Tweet succeeded")
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            })
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        var n = 140 - countElements(textView.text)
        countLabel.text = "\(n)"
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
