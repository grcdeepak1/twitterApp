//
//  ContainerViewController.swift
//  twitterApp
//
//  Created by Deepak on 10/4/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

protocol MentionsViewDelegate {
    func MentionsViewRequested(value: Bool) -> Void
}

class ContainerViewController: UIViewController {
    
    @IBOutlet var fakeNavbarView: UIView!
    var delegate: MentionsViewDelegate?
    @IBOutlet var contentView: UIView!
    var viewControllers: [UIViewController] = [TweetsViewController(nibName: nil, bundle: nil)]
    var homeTimelineVC: UIViewController?
    var profilePageVC: UIViewController?
    var storyboard1: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    //var vc = storyboard1.instantiateViewControllerWithIdentifier("TweetsNavigationController") as UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.barTintColor = UIColorFromRGB(0x55ACEE)
        self.fakeNavbarView.backgroundColor = UIColorFromRGB(0x55ACEE)
        self.contentViewXConstraint.constant = 0
        var homeTimelineVC = storyboard1.instantiateViewControllerWithIdentifier("TweetsNavigationController") as? UIViewController
        self.activeViewController = homeTimelineVC

        
        // Do any additional setup after loading the view.
    }
    
    var activeViewController: UIViewController? {
        didSet(oldViewControllerOrNil) {
            if let oldVC = oldViewControllerOrNil {
                oldVC.willMoveToParentViewController(nil)
                oldVC.view.removeFromSuperview()
                oldVC.removeFromParentViewController()
            }
            if let newVC = activeViewController {
                self.addChildViewController(newVC)
                newVC.view.autoresizingMask = .FlexibleWidth | .FlexibleHeight
                newVC.view.frame = self.contentView.bounds
                self.contentView.addSubview(newVC.view)
                newVC.didMoveToParentViewController(self)
            }
        }
    }

    @IBOutlet var contentViewXConstraint: NSLayoutConstraint!
    
    @IBOutlet var someButton: UIButton!
    
    @IBOutlet var profileButton: UIButton!

    @IBOutlet var mentionsButton: UIButton!
    
    @IBAction func onButtonTap(sender: UIButton) {
        if sender == someButton {
            NSLog("Some Button");
            var homeTimelineVC = storyboard1.instantiateViewControllerWithIdentifier("TweetsNavigationController") as? UIViewController
            self.activeViewController = homeTimelineVC
        } else if sender == profileButton {
            var profilePageVC = storyboard1.instantiateViewControllerWithIdentifier("ProfileNavController") as? UIViewController
            self.activeViewController = profilePageVC
        } else if sender == mentionsButton {
            println("Mentions button pressed")
            delegate?.MentionsViewRequested(true)
            var profilePageVC = storyboard1.instantiateViewControllerWithIdentifier("ProfileNavController") as? UIViewController
            self.activeViewController = profilePageVC
            
        }
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            self.contentViewXConstraint.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    
    @IBAction func onSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .Ended {
            UIView.animateWithDuration(0.35, animations: { () -> Void in
                self.contentViewXConstraint.constant = -160
                self.view.layoutIfNeeded()
            })
        }
        
    }
    


}
