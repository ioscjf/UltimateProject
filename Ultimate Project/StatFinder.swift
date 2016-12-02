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
    var year: String?
    var scores: String?
    var assists: String?
    var offensivePointsPlayed: String?
    var defensivePointsPlayed: String?
    var drops: String?
    var catches: String?
    var completions: String?
    
    init?(json: Dictionary<String, AnyObject>) {
        guard let playerName = json["PlayerName"] as? String else {
            return nil
        }
        self.playerName = playerName
        
        guard let year = json["Year"] as? String else {
            return nil
        }
        self.year = year
        
        guard let scores = json["Scores"] as? String else {
            return nil
        }
        self.scores = scores
        
        guard let assists = json["Assists"] as? String else {
            return nil
        }
        self.assists = assists
        
        guard let offensivePointsPlayed = json["OffensivePointsPlayed"] as? String else {
            return nil
        }
        self.offensivePointsPlayed = offensivePointsPlayed
        
        guard let defensivePointsPlayed = json["DefensivePointsPlayed"] as? String else {
            return nil
        }
        self.defensivePointsPlayed = defensivePointsPlayed
        
        guard let drops = json["Drops"] as? String else {
            return nil
        }
        self.drops = drops
        
        guard let catches = json["Catches"] as? String else {
            return nil
        }
        self.catches = catches
        
        guard let completions = json["Completions"] as? String else {
            return nil
        }
        self.completions = completions
    }
}
