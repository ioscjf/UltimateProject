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
        if let playerName = json["PlayerName"] as? String {
            self.playerName = playerName
        } else {
            self.playerName = ""
        }
        
        if let year = Int((json["Year"] as? String)!) {
            self.year = year
        } else {
            self.year = 0
        }
        
        if let scores = Int((json["Scores"] as? String)!) {
            self.scores = scores
        } else {
            self.scores = 0
        }
        
        if let assists = Int((json["Assists"] as? String)!) {
            self.assists = assists
        } else {
            self.assists = 0
        }
        
        if let offensivePointsPlayed = Int((json["OffensivePointsPlayed"] as? String)!) {
            self.offensivePointsPlayed = offensivePointsPlayed
        } else {
            self.offensivePointsPlayed = 0
        }
        
        if let defensivePointsPlayed = Int((json["DefensivePointsPlayed"] as? String)!) {
            self.defensivePointsPlayed = defensivePointsPlayed
        } else {
            self.defensivePointsPlayed = 0
        }
        
        if let drops = Int((json["Drops"] as? String)!) {
            self.drops = drops
        } else {
            self.drops = 0
        }
        
        if let catches = Int((json["Catches"] as? String)!) {
            self.catches = catches
        } else {
            self.catches = 0
        }
        
        if let completions = Int((json["Completions"] as? String)!) {
            self.completions = completions
        } else {
            self.completions = 0
        }
    }
}
