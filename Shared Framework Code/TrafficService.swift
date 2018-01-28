//
//  TrafficService.swift
//  DataTrackerFramework
//
//  Created by Paul Pfeiffer on 14.10.17.
//  Copyright © 2017 Paul Pfeiffer. All rights reserved.
//

import Foundation

class TrafficService {
    
    let statsCacheKey = "TrafficServiceStatsCache"
    let statsCachedDateKey = "TrafficServiceStatsCacheDate"
    
    class var sharedInstance: TrafficService {
        struct Singleton {
            static let instance = TrafficService()
        }
        return Singleton.instance
    }
    
    private let session = URLSession.shared
    
    let defaults = UserDefaults.init(suiteName: "group.paulpfeiffer.DataTracker")!
    
    func getTrafficStats(_ completion: @escaping (_ stats: TrafficStats?, _ error: NSError?) -> ())  {
        if let cachedStats: TrafficStats = getCachedStats(false) {
            completion(cachedStats, nil)
            return
        }
        
//        let url = URL(string: "https://blog.thepowl.de/test.json")!
        let url = URL(string: "http://pass.telekom.de/api/service/generic/v1/status.json")!

        var request = URLRequest(url: url)
        request.setValue("Mozilla/5.0 (iPhone; CPU iPhone OS 11_1 like Mac OS X) AppleWebKit/604.3.3 (KHTML, like Gecko) Version/11.0 Mobile/15B5078e Safari/604.1", forHTTPHeaderField: "User-Agent")
        self.session.dataTask(with: request) { data, response, error in
            do {
                let statsDictionary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
                let trafficStats = TrafficStats(fromDictionary: statsDictionary!)
                self.cacheStats(trafficStats)
                completion(trafficStats, nil)
            } catch {
                if let trafficStats = self.getCachedStats(true) {
                    completion(trafficStats, nil)
                } else {
                    completion(nil, error as NSError)
                }
            }
            }.resume()
    }
    
    func cacheStats(_ stats: TrafficStats) {
        print(stats)
        let statsData = NSKeyedArchiver.archivedData(withRootObject: stats.trafficStats)
        
        defaults.set(statsData, forKey: statsCacheKey)
        defaults.set(Date(), forKey: statsCachedDateKey)
    }
    
    func getCachedStats(_ force : Bool) -> TrafficStats? {
        if let dict = loadCachedDataForKey(statsCacheKey, cachedDateKey: statsCachedDateKey, force: force) as? NSDictionary {
            return TrafficStats.init(fromDictionary: dict)
        } else { return nil }
    }
    
    func loadCachedDataForKey(_ key: String, cachedDateKey: String, force: Bool) -> AnyObject? {
        var cachedValue: AnyObject?
        
        if let cachedDate = self.defaults.object(forKey: statsCachedDateKey) as? Date {
            let timeInterval = Date().timeIntervalSince(cachedDate)
            if (timeInterval < 60*5 || force ) {
                let cachedData = defaults.object(forKey: key) as? Data
                if cachedData != nil {
                    cachedValue = NSKeyedUnarchiver.unarchiveObject(with: cachedData!) as AnyObject?
                }
            }
        }
        return cachedValue
    }
}

