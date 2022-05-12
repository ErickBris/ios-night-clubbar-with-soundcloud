//
//  Photo.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import Foundation
import SWXMLHash

struct Photo {
    let thumbURL: String!
    let URL: String!
    
    init(_ xmlIndexer: XMLIndexer) {
        thumbURL = xmlIndexer.element?.attributes["thumb"]
        URL = xmlIndexer.element?.attributes["url"]
    }
}
