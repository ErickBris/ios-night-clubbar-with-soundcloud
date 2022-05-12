//
//  SelfScalingImageView.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit

class LayoutImageView: UIImageView {
    override var image: UIImage? {
        didSet {
            if image != nil {
                superview?.layoutIfNeeded()
            }
        }
    }
}
