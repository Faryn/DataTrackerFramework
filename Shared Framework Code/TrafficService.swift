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
        //let url = URL(string: "https://blog.thepowl.de/test.json")!
        let url = URL(string: "http://pass.telekom.de/api/service/generic/v1/status.json")!

        var request = URLRequest(url: url)
        request.setValue("Mozilla/5.0 (iPhone; CPU iPhone OS 11_1 like Mac OS X) AppleWebKit/604.3.3 (KHTML, like Gecko) Version/11.0 Mobile/15B5078e Safari/604.1", forHTTPHeaderField: "User-Agent")
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

