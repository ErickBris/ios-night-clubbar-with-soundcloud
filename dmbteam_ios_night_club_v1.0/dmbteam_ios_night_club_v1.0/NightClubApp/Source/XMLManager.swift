//
//  XMLManager.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import Foundation
import SWXMLHash
import Alamofire

class XMLManager {
    /// Loads the XML from a given path
    /// - parameter resourcePath: The path to the XML - local or remote
    /// - parameter completion: A completion handler for when the parsing is done - returns an error or nil
    static func loadXML(resourcePath: String, completion: ((error: NSError?) -> Void)!) {
        if resourcePath.hasPrefix("http") {
            // Remote XML
            Alamofire.request(.GET, resourcePath)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .Success:
                        self.parseXML(response.result.value!, completion: completion)
                    case .Failure(let error):
                        completion(error: error)
                        print(error)
                    }
            }
            
        } else {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                if let url = NSBundle.mainBundle().URLForResource(resourcePath, withExtension: "xml") {
                    
                    if let xmlData = NSData(contentsOfURL: url) {
                        self.parseXML(xmlData, completion: completion)
                    }
                }
            }
        }
    }
    /// XML parsing form the loaded XML file - constructs the Catalog form the XML data
    /// - parameter xmlData: the loaded(local) or downloaded(remote) xml data
    /// - parameter completion: completion callback closure - returns error or nil
    static func parseXML(xmlData: NSData, completion: ((error: NSError?) -> Void)!) {
        let rootElement = SWXMLHash.parse(xmlData)["nightclub"]
        
        Galleries.sharedGalleries.galleries = rootElement["galleries"]["gallery"].map {Gallery($0)}
        
        Events.sharedEvents.events = rootElement["events"]["event"].map {Event($0)}
        
        xmlClubInfo = ClubInfo(rootElement["clubinfo"])
        
        dispatch_async(dispatch_get_main_queue()) {
            completion?(error: nil)
        }
    }
}