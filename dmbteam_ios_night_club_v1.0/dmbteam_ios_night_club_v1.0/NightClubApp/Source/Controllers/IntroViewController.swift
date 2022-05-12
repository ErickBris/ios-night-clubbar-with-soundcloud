//
//  IntroViewController.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    @IBOutlet weak var startButton: RNLoadingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarHidden = true
        
        startButton.setActivityIndicatorStyle(.White, state: .Disabled)
        startButton.activityIndicatorEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        startButton.hideTextWhenLoading = true
        startButton.loading = false
        startButton.activityIndicatorAlignment = RNActivityIndicatorAlignment.Center
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        UIApplication.sharedApplication().statusBarHidden = false
    }
    @IBAction func startButtonTapped(sender: RNLoadingButton) {
        sender.enabled = false
        sender.loading = true
        
        XMLManager.loadXML(AppConstants.XML.URLPath) { (error) in
            sender.enabled = true
            sender.loading = false
            
            if let err = error {
                
                var errorMessage = err.localizedDescription
                
                if let errorReason = err.localizedFailureReason {
                    errorMessage = errorReason
                }
                
                self.showAlertControllerWithMessage(errorMessage)
                
            } else {
                self.performSegueWithIdentifier("Start", sender: nil)
            }
        }
    }
    
    func showAlertControllerWithMessage(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .ActionSheet)
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel) { (action) in
            // Dismiss button tapped, do nothing
        }
        
        let retryAction = UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default) { (action) in
            self.presentedViewController?.dismissViewControllerAnimated(true, completion:  nil)
            self.startButtonTapped(self.startButton)
        }
        
        alertController.addAction(dismissAction)
        alertController.addAction(retryAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}
