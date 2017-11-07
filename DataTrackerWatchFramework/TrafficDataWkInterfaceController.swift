//
//  TrafficDataWkInterfaceController.swift
//  DataTrackerWatchFramework
//
//  Created by Paul Pfeiffer on 23.10.17.
//  Copyright © 2017 Paul Pfeiffer. All rights reserved.
//

import Foundation
import UIKit

open class TrafficDataWkInterfaceController : NSObject {
    
    open var trafficStats: TrafficStats?
    
    open func fetchStats(_ completion: @escaping (_ error: NSError?) -> ()) {
        TrafficService.sharedInstance.getTrafficStats { stats, error in
            DispatchQueue.main.async {
                self.trafficStats = stats
                completion(error)
            }
        }
    }
}
