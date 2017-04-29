//
//  StatFinder.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 11/29/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import Foundation

struct StatFinder {
    
    var scores: Int?
    var assists: Int?
    var completions: Int?
    var throwingErrors: Int?
    var drops: Int?
    var ds: Int?
    var goallineThrowingErrors: Int?
    var goallineDrops: Int?
    var goallineDs: Int?
    var fouls: Int?
    var pulls: Int?
    var pullsOutOfBounds: Int?
    var offensivePointsPlayed: Int?
    var defensivePointsPlayed: Int?
    
    init?(json: Dictionary<String, AnyObject>) {
        if let s = Int((json["scores"] as? String)!) {
            self.scores = s
        } else {
            self.scores = 0
        }
        
        if let a = Int((json["assists"] as? String)!) {
            self.assists = a
        } else {
            self.assists = 0
        }
        
        if let c = Int((json["completions"] as? String)!) {
            self.completions = c
        } else {
            self.completions = 0
        }
        
        if let te = Int((json["throwingErrors"] as? String)!) {
            self.throwingErrors = te
        } else {
            self.throwingErrors = 0
        }
        
        if let d = Int((json["drops"] as? String)!) {
            self.drops = d
        } else {
            self.drops = 0
        }
        
        if let ds = Int((json["ds"] as? String)!) {
            self.ds = ds
        } else {
            self.ds = 0
        }
        
        if let gte = Int((json["goallineThrowingErrors"] as? String)!) {
            self.goallineThrowingErrors = gte
        } else {
            self.goallineThrowingErrors = 0
        }
        
        if let gd = Int((json["goallineDrops"] as? String)!) {
            self.goallineDrops = gd
        } else {
            self.goallineDrops = 0
        }
        
        if let gds = Int((json["goallineDs"] as? String)!) {
            self.goallineDs = gds
        } else {
            self.goallineDs = 0
        }
        
        if let f = Int((json["fouls"] as? String)!) {
            self.fouls = f
        } else {
            self.fouls = 0
        }
        
        if let p = Int((json["pulls"] as? String)!) {
            self.pulls = p
        } else {
            self.pulls = 0
        }
        
        if let poob = Int((json["pullsOutOfBounds"] as? String)!) {
            self.pullsOutOfBounds = poob
        } else {
            self.pullsOutOfBounds = 0
        }
        
        if let opp = Int((json["offensivePointsPlayed"] as? String)!) {
            self.offensivePointsPlayed = opp
        } else {
            self.offensivePointsPlayed = 0
        }
        
        if let dpp = Int((json["defensivePointsPlayed"] as? String)!) {
            self.defensivePointsPlayed = dpp
        } else {
            self.defensivePointsPlayed = 0
        }
    }
}
