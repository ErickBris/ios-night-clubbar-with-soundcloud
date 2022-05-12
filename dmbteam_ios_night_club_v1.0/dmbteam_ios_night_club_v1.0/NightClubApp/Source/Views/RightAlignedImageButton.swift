//
//  RightAlignedImageButton.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit

class RightAlignedImageButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard imageView != nil else {
            return
        }
        
        imageEdgeInsets = UIEdgeInsetsMake(0, CGRectGetWidth(bounds) - CGRectGetWidth(imageView!.frame), 0, 0)
        
    }

}
