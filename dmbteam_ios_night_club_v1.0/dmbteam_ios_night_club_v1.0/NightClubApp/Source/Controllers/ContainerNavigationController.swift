//
//  ContainerNavigationController.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit

class ContainerNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = false
    }
}
