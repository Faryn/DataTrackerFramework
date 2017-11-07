//
//  TrafficDataViewController.swift
//  DataTrackerFramework
//
//  Created by Paul Pfeiffer on 14.10.17.
//  Copyright © 2017 Paul Pfeiffer. All rights reserved.
//

import Foundation

open class TrafficDataViewController: UIViewController {
    
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
