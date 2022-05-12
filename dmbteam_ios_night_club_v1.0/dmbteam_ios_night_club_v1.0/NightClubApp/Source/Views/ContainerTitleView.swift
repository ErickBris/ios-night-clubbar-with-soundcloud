//
//  ContainerTitleView.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit

class ContainerTitleView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            if (newValue != nil){
                layoutIfNeeded()
                if titleImageView.alpha > 0 {
                    titleLabel.text = newValue
                    UIView.animateWithDuration(0.5) {
                        self.titleLabel.alpha = 1
                        self.titleImageView.alpha = 0
                    }
                } else {
                    UIView.transitionWithView(titleLabel, duration: 0.5, options: .TransitionCrossDissolve, animations: {
                        self.titleLabel.alpha = 0
                        self.titleLabel.text = newValue
                        self.titleLabel.alpha = 1
                        }, completion: nil)
                }
            } else if titleLabel.alpha > 0 {
                UIView.animateWithDuration(0.75) {
                    self.titleLabel.alpha = 0
                    self.titleImageView.alpha = 1
                }
            }
        }
    }
}
