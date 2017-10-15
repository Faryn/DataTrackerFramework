//
//  TrafficService.swift
//  DataTrackerFramework
//
//  Created by Paul Pfeiffer on 14.10.17.
//  Copyright © 2017 Paul Pfeiffer. All rights reserved.
//

import Foundation

class TrafficService {
    
    class var sharedInstance: TrafficService {
        struct Singleton {
            static let instance = TrafficService()
        }
        return Singleton.instance
    }
    
    private let session = URLSession.shared
    var trafficStats : TrafficStats?
    
    func getTrafficStats(_ completion: @escaping (_ stats: TrafficStats?, _ error: NSError?) -> ())  {
        let url = URL(string: "https://blog.thepowl.de/test.json")!
        let request = URLRequest(url: url)
        self.session.dataTask(with: request) { data, response, error in
            do {
                let statsDictionary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
                self.trafficStats = TrafficStats(fromDictionary: statsDictionary!)
                completion(self.trafficStats, nil)
            } catch {
                completion(nil, error as NSError)
            }
            }.resume()
    }
}

