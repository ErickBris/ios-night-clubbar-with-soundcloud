//
//  ContentTabBarController.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit

class FadeTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        
        let toVC = transitionContext.viewControllerForKey(
            UITransitionContextToViewControllerKey)
        
        containerView!.addSubview(toVC!.view)
        toVC!.view.alpha = 0.0
        
        let duration = transitionDuration(transitionContext)
        UIView.animateWithDuration(duration, animations: {
            toVC!.view.alpha = 1.0
            }, completion: { finished in
                let cancelled = transitionContext.transitionWasCancelled()
                transitionContext.completeTransition(!cancelled)
        })
    }
}

class ContentTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    @IBOutlet weak var containerTitleView: ContainerTitleView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view.clipsToBounds = false
        delegate = self
    }
    
    override internal var selectedIndex: Int {
        didSet {
            containerTitleView.title = viewControllers![selectedIndex].title
        }
    }
    
    func tabBarController(tabBarController: UITabBarController, animationControllerForTransitionFromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return FadeTransition()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Menu" {
//            navigationController?.setNavigationBarHidden(true, animated: true)
//            UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
            (segue.destinationViewController as! MenuViewController).contentTabbarController = self
        }
    }
}
