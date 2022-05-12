//
//  EventTableViewCell.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    @IBOutlet weak var eventImageView: UIImageView!
    
    func fillWithEvent(event: Event) -> UITableViewCell {
        titleLabel.text = event.title
        subtitleLabel.text = event.subtitle
        eventDateLabel.text = event.date
        eventImageView.setImageWithPath(event.image)
        
        return self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        subtitleLabel.text = nil
        eventDateLabel.text = nil
        
        eventImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectedBackgroundView?.frame = containerView.frame
    }
}
