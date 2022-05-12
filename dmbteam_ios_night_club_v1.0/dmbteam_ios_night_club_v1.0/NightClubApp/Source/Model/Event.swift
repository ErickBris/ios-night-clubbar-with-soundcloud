//
//  Event.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import Foundation
import SWXMLHash

/// The Event struct
struct Event {
    
    let title: String!
    let subtitle: String!
    let description: String!
    let image: String!
    
    let date: String!
    let starts: String!
    let ends: String!
    
    init(_ xmlIndexer: XMLIndexer) {
        title = xmlIndexer["title"].element?.text
        subtitle = xmlIndexer["subtitle"].element?.text
        description = xmlIndexer["description"].element?.text
        image = xmlIndexer["image"].element?.text
        
        date = xmlIndexer.element?.attributes["date"]
        starts = xmlIndexer.element?.attributes["starts"]
        ends = xmlIndexer.element?.attributes["ends"]
    }
}
