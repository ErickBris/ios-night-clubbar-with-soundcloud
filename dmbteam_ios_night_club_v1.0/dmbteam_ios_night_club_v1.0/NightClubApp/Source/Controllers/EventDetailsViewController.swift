//
//  EventDetailsViewController.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var eventTimeTextView: UITextView!
    @IBOutlet weak var eventImageView: LayoutImageView!
    
    var event: Event? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = event?.title
        
        subtitleLabel.text = event?.subtitle
        descriptionLabel.text = event?.description
        eventTimeTextView.text = event!.date + " " + event!.starts + " " + event!.ends
        
        eventImageView.setImageWithPath(event!.image)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard eventImageView.image != nil else {
            return
        }
        eventImageView.image = eventImageView.image?.scaledImage(CGRectGetWidth(view.bounds))
    }

}
