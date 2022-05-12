//
//  EmptySegue.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit

class MultiEmbedSegue: UIStoryboardSegue {
    
    override func perform() {
        
        if sourceViewController.childViewControllers.isEmpty {
//            destinationViewController.view.frame = sourceViewController.view.bounds
            sourceViewController.addChildViewController(destinationViewController)
//            sourceViewController.view.addSubview(destinationViewController.view)
            destinationViewController.didMoveToParentViewController(sourceViewController)
        } else {
            sourceViewController.addChildViewController(destinationViewController)
            swapChildViewControllers(sourceViewController.childViewControllers.first!, toViewController: destinationViewController)
        }
    }
    
    func swapChildViewControllers(fromViewController: UIViewController, toViewController: UIViewController) {
//        destinationViewController.view.frame = sourceViewController.view.bounds
        self.sourceViewController.title = toViewController.title
        
        sourceViewController.transitionFromViewController(fromViewController, toViewController: toViewController, duration: 0.5, options: .TransitionCrossDissolve, animations: nil, completion:  nil)
    }
}
