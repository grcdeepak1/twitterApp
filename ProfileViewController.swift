//
//  ProfileViewController.swift
//  twitterApp
//
//  Created by Deepak on 10/5/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User!
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var profileName: UILabel!
    
    @IBOutlet var profileScreenname: UILabel!
    
    @IBOutlet var profilePageControl: UIPageControl!
    
    @IBOutlet var profileHeaderView: UIView!
    
    @IBOutlet var profileBGImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
