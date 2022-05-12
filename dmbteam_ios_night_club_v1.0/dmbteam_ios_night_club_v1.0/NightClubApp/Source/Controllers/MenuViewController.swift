//
//  MenuViewController.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var fbButton: URLButton!
    @IBOutlet weak var twitterButton: URLButton!
    @IBOutlet weak var instagramButton: URLButton!
    
    var contentTabbarController: ContentTabBarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let clubInfo = xmlClubInfo {
            fbButton.URL = clubInfo.facebookURL
            twitterButton.URL = clubInfo.twitterURL
            instagramButton.URL = clubInfo.instagramURL
        }
    }
    
    @IBAction func dismiss() {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func menuButtonTapped(sender: UIButton) {
        guard contentTabbarController != nil else { return }
        dismiss()
        parentViewController as? ContentTabBarController
        contentTabbarController?.selectedIndex = sender.tag
    }
    @IBAction func socialButtonTapped(sender: URLButton) {
        if UIApplication.sharedApplication().canOpenURL(sender.URL!) {
            UIApplication.sharedApplication().openURL(sender.URL!)
        }
    }
    
}
