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
        get(clientURLRequest("teams.php"), message: nil) { (success, object) in
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
        get(clientURLRequest("showPlayers.php"), message: nil) { (success, object) in
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
        get(clientURLRequest("stats.php"), message: nil) { (success, object) in
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
    
    func addPlayer(player: PlayerFinder) {
        let postString = "nameFirst=\(player.nameFirst!)&nameLast=\(player.nameLast!)&position=\(player.position!)&birthday=\(player.birthday!)&heightFeet=\(player.heightFeet!)&heightInches=\(player.heightInches!)&weight=\(player.weight!)&jerseyNum=\(player.jerseyNum!)&nickname=\(player.nickname!)"
        post(clientURLRequest("addPlayer.php"), message: postString) { (success, object) in
        }
    }
    
    func addTeam(team: TeamFinder) {
        let postString = "teamName=\(team.team!)&school=\(team.school!)&competitionDivision=\(team.division!)&year=\(team.year!)&state=\(team.state!)&region=\(team.region!)&conference=\(team.conference!)"
        post(clientURLRequest("addTeam.php"), message: postString) { (success, object) in
        }
    }
    
    func addStats(stat: StatFinder) {
        let postString = "playerName=\(stat.playerName!)&year=\(stat.year!)&scores=\(stat.scores!)&assists=\(stat.assists!)&offensivePointsPlayed=\(stat.offensivePointsPlayed!)&defensivePointsPlayed=\(stat.defensivePointsPlayed!)&drops=\(stat.drops!)&catches=\(stat.catches!)&completions=\(stat.completions!)"
        post(clientURLRequest("addStats.php"), message: postString) { (success, object) in
        }
    }
    
    fileprivate func post(_ request: NSMutableURLRequest, message: String?, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request, method: "POST", message: message, completion: completion)
    }
    
    fileprivate func get(_ request: NSMutableURLRequest, message: String?, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request, method: "GET", message: message, completion: completion)
    }
    
    fileprivate func clientURLRequest(_ path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: URL(string: "http://45.55.95.100/mattTest/"+path)!)
        return request
    }
    
    fileprivate func dataTask(_ request: NSMutableURLRequest, method: String, message: String?, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        request.httpMethod = method
        request.httpBody = message?.data(using: String.Encoding.utf8)

        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let data = data {
                
                // MARK: - For debugging purposes
                 let responseString = String(data: data, encoding: .utf8)
                 print("responseString = \(responseString)")
                
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                    completion(true, json as AnyObject?)
                } else {
                    completion(false, json as AnyObject?)
                    print("ERROR: CONNECTION FAILED")
                }
            }
        })  .resume()
    }
}
