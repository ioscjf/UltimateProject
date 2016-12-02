//
//  JsonParser.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 11/8/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import Foundation

class JsonParser {
    
    static let jsonClient = JsonParser()
    
    func getTeams(_ completion: @escaping ([TeamFinder]) -> ()) {
        get(clientURLRequest("teams.php")) { (success, object) in
            var teams: [TeamFinder] = []
            
            if let object = object as? Dictionary<String, AnyObject> {
                if let results = object["TEAMS"] as? [Dictionary<String, AnyObject>] {
                    for result in results {
                        if let team = TeamFinder(json: result) {
                            teams.append(team)
                        }
                    }
                }
            }
            completion(teams)
        }
    }
    
    func getPlayers(_ completion: @escaping ([PlayerFinder]) -> ()) {
        get(clientURLRequest("players.php")) { (success, object) in
            var players: [PlayerFinder] = []
            
            if let object = object as? Dictionary<String, AnyObject> {
                if let results = object["PLAYERS"] as? [Dictionary<String, AnyObject>] {
                    for result in results {
                        if let player = PlayerFinder(json: result) {
                            players.append(player)
                        }
                    }
                }
            }
            completion(players)
        }
    }
    
    func getStats(_ completion: @escaping ([StatFinder]) -> ()) {
        get(clientURLRequest("stats.php")) { (success, object) in
            var stats: [StatFinder] = []
            
            if let object = object as? Dictionary<String, AnyObject> {
                if let results = object["STATS"] as? [Dictionary<String, AnyObject>] {
                    for result in results {
                        if let stat = StatFinder(json: result) {
                            stats.append(stat)
                        } else {
                            print(result)
                        }
                    }
                }
            }
            completion(stats)
        }
    }
    
    fileprivate func get(_ request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request, method: "GET", completion: completion)
    }
    
    fileprivate func clientURLRequest(_ path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: URL(string: "http://45.55.95.100/"+path)!)
        
        return request
    }
    
    fileprivate func dataTask(_ request: NSMutableURLRequest, method: String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        request.httpMethod = method
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                    completion(true, json as AnyObject?)
                } else {
                    completion(false, json as AnyObject?)
                }
            }
        })  .resume()
    }
}
