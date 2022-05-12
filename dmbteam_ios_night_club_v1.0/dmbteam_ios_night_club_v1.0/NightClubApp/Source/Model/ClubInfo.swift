//
//  ClubInfo.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import Foundation
import SWXMLHash

var xmlClubInfo: ClubInfo? = nil

struct SoundcloudSettings {
    let playlistURL: String!
    let clientID: String!
    let clientSecret: String!
}

struct ClubInfo {
    /*
    <clubinfo>
    <name> </name>
    <slogan> </slogan>
    <description> </description>
    <workhours> </workhours>
    <phonenumber> </phonenumber>
    <location> </location>
    <facebook> </facebook>
    <twitter> </twitter>
    <instagram> </instagram>
    </clubinfo>
    */
    
    let name: String!
    let slogan: String!
    let description: String!
    let workHours: String!
    let phoneNumber: String!
    let location: String!
    
    let soundcloudSettings: SoundcloudSettings!
    
    private(set) var facebookURL: NSURL? = nil
    private(set) var instagramURL: NSURL? = nil
    private(set) var twitterURL: NSURL? = nil
    
    init(_ xmlIndexer: XMLIndexer) {
        name = xmlIndexer["name"].element?.text
        slogan = xmlIndexer["slogan"].element?.text
        description = xmlIndexer["description"].element?.text
        workHours = xmlIndexer["workhours"].element?.text
        phoneNumber = xmlIndexer["phonenumber"].element?.text
        location = xmlIndexer["location"].element?.text
        
        if let fbURLString = xmlIndexer["facebook"].element?.text {
            facebookURL = NSURL(string: fbURLString)
        }
        
        if let twttrURLString = xmlIndexer["twitter"].element?.text {
            twitterURL =  NSURL(string: twttrURLString)
        }
        
        if let instgURLString = xmlIndexer["instagram"].element?.text {
            instagramURL =  NSURL(string: instgURLString)
        }
        
        let scPlaylistURL = xmlIndexer["soundcloud"].element?.text
        let scClientID = xmlIndexer["soundcloudClientID"].element?.text
        let scClientSecret = xmlIndexer["soundcloudClientSecret"].element?.text
        soundcloudSettings = SoundcloudSettings(playlistURL: scPlaylistURL, clientID: scClientID, clientSecret: scClientSecret)
    }
}