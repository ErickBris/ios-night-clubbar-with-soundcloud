//
//  TrackTableViewCell.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit
import Soundcloud

class TrackTableViewCell: UITableViewCell {
    @IBOutlet weak var playingImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!

    @IBOutlet weak var trackDurationLabel: UILabel!
    
    @IBOutlet weak var soundCloudURLButton: URLButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = UIColor.blackColor()
    }
    
    func configureForTrack(track: Track) {
        titleLabel.text = track.title
        artistLabel.text = track.createdBy.username
        
        let formatter = NSDateComponentsFormatter()
        formatter.unitsStyle = .Positional
        formatter.allowedUnits = [.Minute, .Second]  
        trackDurationLabel.text = formatter.stringFromTimeInterval(track.duration/1000)
        
        soundCloudURLButton.URL = track.permalinkURL
    }
    
    @IBAction func trackURLButtonTapped(sender: URLButton) {
        if UIApplication.sharedApplication().canOpenURL(sender.URL!) {
            UIApplication.sharedApplication().openURL(sender.URL!)
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        playingImageView.highlighted = selected
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectedBackgroundView?.frame = contentView.frame
    }
}
