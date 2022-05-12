//
//  URLButton.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit

class URLButton: UIButton {

    var URL: NSURL? {
        didSet {
            hidden = (URL == nil)
        }
    }
}
