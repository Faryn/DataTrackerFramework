//
//  Traffic.swift
//  DataTrackerFramework
//
//  Created by Paul Pfeiffer on 12.10.17.
//  Copyright © 2017 Paul Pfeiffer. All rights reserved.
//

import Foundation

open class TrafficStats {
    var trafficStats: NSDictionary? {
        didSet {
            
        }
    }
    open var remainingTimeString : String?
    open var usedVolumeString: String?
    open var initialVolumeString: String?

    
    public init(fromDictionary: NSDictionary) {
        trafficStats = fromDictionary
        remainingTimeString = trafficStats?.value(forKey: "remainingTimeStr") as? String
        usedVolumeString = trafficStats?.value(forKey: "usedVolumeStr") as? String
        initialVolumeString = trafficStats?.value(forKey: "initialVolumeStr") as? String
    }
    
}
