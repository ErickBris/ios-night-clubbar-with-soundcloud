//
//  AppDelegate.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        application.statusBarStyle = .LightContent
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().shadowImage = UIImage()
        let colors = [
            UIColor(white: 0.0, alpha: 1.0),
            UIColor(white: 0.0, alpha: 0.5)
        ]
        let gradientImage = UIImage.navigationBarBackgroundImage(colors, frame:CGRectMake(0, 0, 1, 64))
        UINavigationBar.appearance().setBackgroundImage(gradientImage, forBarMetrics: .Default)
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.systemFontOfSize(17)]
        
        UIToolbar.appearance().setBackgroundImage(UIImage(), forToolbarPosition: .Any, barMetrics: .Default)
        UIToolbar.appearance().setShadowImage(UIImage(), forToolbarPosition: .Any)
        
        return true
    }
}

