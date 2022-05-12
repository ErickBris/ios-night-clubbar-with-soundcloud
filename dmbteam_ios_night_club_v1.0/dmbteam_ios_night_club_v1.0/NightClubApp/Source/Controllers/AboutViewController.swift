//
//  AboutViewController.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var workHoursTextView: UITextView!
    @IBOutlet weak var locationTextView: UITextView!
    @IBOutlet weak var phoneNumberTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var textViews: [UITextView]!
    
    let maskLayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maskLayer.shadowColor = UIColor(white: 0.0, alpha: 0.9).CGColor
        maskLayer.shadowRadius = 5
        maskLayer.shadowOpacity = 1
        maskLayer.shadowOffset = .zero
        imageView.layer.mask = maskLayer
        
        title = nil
        
        populateClubInfo()
    }
    
    deinit {
        print("")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        contentScrollView.flashScrollIndicators()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        maskLayer.frame = imageView.bounds
        maskLayer.shadowPath = CGPathCreateWithRect(CGRectInset(imageView.bounds, 0, 5), nil)
        
        imageView.image = imageView.image?.scaledImage(CGRectGetWidth(view.bounds))
    }
    
    func populateClubInfo() {
        nameLabel.text = xmlClubInfo?.name
        sloganLabel.text = xmlClubInfo?.slogan
        descriptionLabel.text = xmlClubInfo?.description
        workHoursTextView.text = xmlClubInfo?.workHours
        locationTextView.text = xmlClubInfo?.location
        phoneNumberTextView.text = xmlClubInfo?.phoneNumber
        
        view.layoutIfNeeded()
    }
}
