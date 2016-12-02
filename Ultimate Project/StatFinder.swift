//
//  StatFinder.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 11/29/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import Foundation

struct StatFinder {
    
    var playerName: String?
    var year: Int?
    var scores: Int?
    var assists: Int?
    var offensivePointsPlayed: Int?
    var defensivePointsPlayed: Int?
    var drops: Int?
    var catches: Int?
    var completions: Int?
    
    init?(json: Dictionary<String, AnyObject>) {
        guard let playerName = json["PlayerName"] as? String else {
            return nil
        }
        self.playerName = playerName
        
        guard let year = json["Year"] as? Int else {
            return nil
        }
        self.year = year
        
        guard let scores = json["Scores"] as? Int else {
            return nil
        }
        self.scores = scores
        
        guard let assists = json["Assists"] as? Int else {
            return nil
        }
        self.assists = assists
        
        guard let offensivePointsPlayed = json["OffensivePointsPlayed"] as? Int else {
            return nil
        }
        self.offensivePointsPlayed = offensivePointsPlayed
        
        guard let defensivePointsPlayed = json["DefensivePointsPlayed"] as? Int else {
            return nil
        }
        self.defensivePointsPlayed = defensivePointsPlayed
        
        guard let drops = json["Drops"] as? Int else {
            return nil
        }
        self.drops = drops
        
        guard let catches = json["Catches"] as? Int else {
            return nil
        }
        self.catches = catches
        
        guard let completions = json["Completions"] as? Int else {
            return nil
        }
        self.completions = completions
    }
}
