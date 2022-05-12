//
//  Gallery.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import Foundation
import SWXMLHash

/// The Gallery struct
struct Gallery {
    
    let date: String!
    let coverImage: String!
    let photos: [Photo]!
    
    init(_ xmlIndexer: XMLIndexer) {
        date = xmlIndexer.element?.attributes["date"]
        photos = xmlIndexer["photos"]["photo"].map { Photo($0) }
        coverImage = xmlIndexer.element?.attributes["cover"]
    }
}
