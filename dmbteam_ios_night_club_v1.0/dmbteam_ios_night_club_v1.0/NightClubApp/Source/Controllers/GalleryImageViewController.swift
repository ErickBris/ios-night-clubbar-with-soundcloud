//
//  GalleryImageViewController.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit

class GalleryImageViewController: UIViewController {

    var imageURL: String?
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        guard imageURL != nil else {
            return
        }
        
        imageView.setImageWithPath(imageURL!)
    }
    
    @IBAction func dismiss() {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
