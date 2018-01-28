//
//  Traffic.swift
//  DataTrackerFramework
//
//  Created by Paul Pfeiffer on 12.10.17.
//  Copyright © 2017 Paul Pfeiffer. All rights reserved.
//

import Foundation

open class TrafficStats {
    open var trafficStats: NSDictionary? {
        didSet {
            
        }
    }
    open var remainingTimeString : String?
    open var usedVolumeString: String?
    open var initialVolumeString: String?
    open var remainingTimeSeconds: Int?
    open var nextUpdate: Int?
    open var usedPercentage: Int?
    open var subscriptions: NSArray?
    open var initialVolume: Int?
    open var usedVolume: Int?
    open var downSpeed: Int?
    open var upSpeed: Int?
    open var downSpeedString: String?
    open var upSpeedString: String?
    open var initialVolumeMB: Int? {
        get {
            return initialVolume! / 1024 / 1024
        }
    }
    
    open var usedVolumeMB: Int? {
        get {
            if usedVolume != 0 {
                return usedVolume! / 1024 / 1024
            } else { return 0 }
        }
    }
    

    
    public init(fromDictionary: NSDictionary) {
        trafficStats = fromDictionary
        remainingTimeString = trafficStats?.value(forKey: "remainingTimeStr") as? String
        usedVolumeString = trafficStats?.value(forKey: "usedVolumeStr") as? String
        initialVolumeString = trafficStats?.value(forKey: "initialVolumeStr") as? String
        remainingTimeSeconds = trafficStats?.value(forKey: "remainingSeconds") as? Int
        nextUpdate = trafficStats?.value(forKey: "nextUpdate") as? Int
        usedPercentage = trafficStats?.value(forKey: "usedPercentage") as? Int
        subscriptions = trafficStats?.value(forKey: "subscriptions") as? NSArray
        initialVolume = trafficStats?.value(forKey: "initialVolume") as? Int
        downSpeed = trafficStats?.value(forKey: "downSpeed") as? Int
        upSpeed = trafficStats?.value(forKey: "upSpeed") as? Int
        downSpeedString = trafficStats?.value(forKey: "downSpeedStr") as? String
        upSpeedString = trafficStats?.value(forKey: "upSpeedStr") as? String
        usedVolume = trafficStats?.value(forKey: "usedVolume") as? Int
        
        
    }
    
}
