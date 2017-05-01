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
                        } else {
                            print(result)
                        }
                    }
                }
            }
            completion(teams)
        }
    }
    
    func getMyPlayer(team: String, twitter: String, _ completion: @escaping ([PlayerFinder]) -> ()) {
        let postString = "teamName=\(team)&twitterHandle=\(twitter)"
        post(clientURLRequest("myPlayer.php"), message: postString) { (success, object) in
            var players: [PlayerFinder] = []
            if let object = object as? Dictionary<String, AnyObject> {
                if let results = object["PLAYER"] as? [Dictionary<String, AnyObject>] {
                    for result in results {
                        if let player = PlayerFinder(json: result) {
                            players.append(player)
                        } else {
                            print(result)
                        }
                    }
                }
            }
            completion(players)
        }
    }
    
    func getPlayerFromGame(team: String, twitter: String, opponent: String, _ completion: @escaping ([PlayerFinder]) -> ()) {
        let postString = "teamName=\(team)&twitterHandle=\(twitter)&opponent=\(opponent)"
        post(clientURLRequest("playerFromGame.php"), message: postString) { (success, object) in
            var players: [PlayerFinder] = []
            if let object = object as? Dictionary<String, AnyObject> {
                if let results = object["PLAYER"] as? [Dictionary<String, AnyObject>] {
                    for result in results {
                        if let player = PlayerFinder(json: result) {
                            players.append(player)
                        } else {
                            print(result)
                        }
                    }
                }
            }
            completion(players)
        }
    }
    
    func getStatsFromPlayer(nameFirst: String, nameLast: String, opponent: String, teamName: String, _ completion: @escaping ([StatFinder]) -> ()) {
        let postString = "nameFirst=\(nameFirst)&nameLast=\(nameLast)&opponent=\(opponent)&teamName=\(teamName)"
        post(clientURLRequest("statsFromPlayer.php"), message: postString) { (success, object) in
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
    
    func getMyGames(team: String, twitter: String, _ completion: @escaping ([GameFinder]) -> ()) {
        let postString = "teamName=\(team)&twitterHandle=\(twitter)"
        post(clientURLRequest("myGame.php"), message: postString) { (success, object) in
            var players: [GameFinder] = []
            if let object = object as? Dictionary<String, AnyObject> {
                if let results = object["GAME"] as? [Dictionary<String, AnyObject>] {
                    for result in results {
                        if let player = GameFinder(json: result) {
                            players.append(player)
                        } else {
                            print(result)
                        }
                    }
                }
            }
            completion(players)
        }
    }
    
    func getPlayers(_ completion: @escaping ([PlayerFinder]) -> ()) {
        get(clientURLRequest("players.php"), message: nil) { (success, object) in
            var players: [PlayerFinder] = []
            
            if let object = object as? Dictionary<String, AnyObject> {
                if let results = object["PLAYER"] as? [Dictionary<String, AnyObject>] {
                    for result in results {
                        if let player = PlayerFinder(json: result) {
                            players.append(player)
                        } else {
                            print(result)
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
    
    func getGames(_ completion: @escaping ([GameFinder]) -> ()) {
        get(clientURLRequest("games.php"), message: nil) { (success, object) in
            var games: [GameFinder] = []
            if let object = object as? Dictionary<String, AnyObject> {
                if let results = object["GAMES"] as? [Dictionary<String, AnyObject>] {
                    for result in results {
                        if let game = GameFinder(json: result) {
                            games.append(game)
                        } else{
                            print(result)
                        }
                    }
                }
            }
            completion(games)
        }
    }
    
    func login(team: String, password: String, _ completion: @escaping (TeamFinder) -> ()) {
        let postString = "teamName=\(team)&password=\(password)"
        post(clientURLRequest("login.php"), message: postString) { (success, object) in
            var team: [TeamFinder] = []
            if let object = object as? Dictionary<String, AnyObject> {
                if let results = object["LOGIN"] as? [Dictionary<String, AnyObject>] {
                    for result in results {
                        if let t = TeamFinder(json: result) {
                            team.append(t)
                        } else{
                            print(results)
                        }
                    }
                }
            }
            if team.count == 1 { // should only be one team in array
                completion(team[0])
            }
        }
    }
    
    func addPlayer(player: PlayerFinder, _ completion: @escaping () -> ()) {
        let defaults = UserDefaults.standard
        let t = defaults.object(forKey: "team") as! String

        let postString = "nameFirst=\(player.nameFirst!)&nameLast=\(player.nameLast!)&position=\(player.position!)&birthday=\(player.birthday!)&heightFeet=\(player.heightFeet!)&heightInches=\(player.heightInches!)&weight=\(player.weight!)&jerseyNum=\(player.jerseyNum!)&nickname=\(player.nickname!)&team=\(t)"
        post(clientURLRequest("addPlayer.php"), message: postString) { (success, object) in
            
            completion()
        }
    }
    
    func addTeam(team: TeamFinder) {
        let postString = "teamName=\(team.teamName!)&school=\(team.school!)&competitionDivision=\(team.division!)&city=\(team.city!)&state=\(team.state!)&region=\(team.region!)&conference=\(team.conference!)&genderDivision=\(team.genderDivision!)&twitterHandle=\(team.twitterHandle!)&password=\(team.password!)"
        post(clientURLRequest("addTeam.php"), message: postString) { (success, object) in
        }
    }
    
    func addStats(playerNameFirst: String, playerNameLast: String, opponent: String, stat: StatFinder) {
        let defaults = UserDefaults.standard
        let t = defaults.object(forKey: "team") as! String
        let postString = "nameFirst=\(playerNameFirst)&nameLast=\(playerNameLast)&opponent=\(opponent)&teamName=\(t)&scores=\(stat.scores!)&assists=\(stat.assists!)&completions=\(stat.completions!)&throwingErrors=\(stat.throwingErrors!)&drops=\(stat.drops!)&ds=\(stat.ds!)&goallineThrowingErrors=\(stat.goallineThrowingErrors!)&goallineDrops=\(stat.goallineDrops!)&goallineDs=\(stat.goallineDs!)&fouls=\(stat.fouls!)&pulls=\(stat.pulls!)&pullsOutOfBounds=\(stat.pullsOutOfBounds!)&offensivePointsPlayed=\(stat.offensivePointsPlayed!)&defensivePointsPlayed=\(stat.defensivePointsPlayed!)"
        post(clientURLRequest("addStats.php"), message: postString) { (success, object) in
        }
    }
    
    func addGames(game: GameFinder, _ completion: @escaping() -> ()) {
        let defaults = UserDefaults.standard
        let t = defaults.object(forKey: "team") as! String
        
        let postString = "date=\(game.date!)&tournament=\(game.tournament!)&gameNum=\(game.gameNum!)&location=\(game.location!)&opponent=\(game.opponent!)&team=\(t)"
        post(clientURLRequest("addGame.php"), message: postString) { (success, object) in
            
            completion()
        }
    }
    
    fileprivate func post(_ request: NSMutableURLRequest, message: String?, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request, method: "POST", message: message, completion: completion)
    }
    
    fileprivate func get(_ request: NSMutableURLRequest, message: String?, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request, method: "GET", message: message, completion: completion)
    }
    
    fileprivate func clientURLRequest(_ path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: URL(string: "http://45.55.95.100/connor/"+path)!)
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
                 print("responseString = \(String(describing: responseString))")
                
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                    completion(true, json as AnyObject?)
                } else {
                    completion(false, json as AnyObject?)
                    print("ERROR: CONNECTION FAILED")
                    if let httpResponse = response as? HTTPURLResponse {
                        print("error \(httpResponse.statusCode)")
                    }
                }
            }
        })  .resume()
    }
}
