//
//  ViewController.swift
//  twitterApp
//
//  Created by Deepak on 9/27/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColorFromRGB(0x55ACEE)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                self.user = user
                //perform segue
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                //handle login error
            }
        }
    }
    
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        self.view.endEditing(true)
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        /*
        if (segue.identifier == "loginSegue") {
            var nav = segue.destinationViewController as UINavigationController
            if nav.viewControllers[0] is TweetsViewController {
                var tweetsVc = nav.viewControllers[0] as TweetsViewController
                // pass data to next view
                println("In viewController : User : \(user?.name)")
                tweetsVc.user = user?
            }
            
        }*/

    }
    
    //MARK - HelperFunctions
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

