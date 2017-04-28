//
//  GameFinder.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 4/11/17.
//  Copyright © 2017 Connor Fitzpatrick. All rights reserved.
//

import Foundation

struct GameFinder {

    var date: String?
    var tournament: String?
    var gameNum: Int?
    var location: String?
    var opponent: String?
    
    init?(json: Dictionary<String, AnyObject>) {
        if let date = json["date"] as? String {
            self.date = date
        } else {
            self.date = "2017-01-01"
        }
        
        if let tourney = json["tournament"] as? String {
            self.tournament = tourney
        } else {
            self.tournament = ""
        }
        
        if let game = Int((json["gameNum"] as? String)!) {
            self.gameNum = game
        } else {
            self.gameNum = 0
        }
        
        if let location = json["location"] as? String {
            self.location = location
        } else {
            self.location = ""
        }
        
        if let opponent = json["opponent"] as? String {
            self.opponent = opponent
        } else {
            self.opponent = ""
        }
    }
}
