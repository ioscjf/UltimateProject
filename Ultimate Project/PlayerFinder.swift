//
//  PlayerFinder.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 11/17/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import Foundation

struct PlayerFinder {
    
    var player: String?
    var position: String?
    var age: Int?
    var height: String? // NOTE: How did we decide to format this?
    var school: String?
    var jerseyNumber: Int?
    
    init?(json: Dictionary<String, AnyObject>) {
        if let name = json["Name"] as? String {
            self.player = name
        } else {
            self.player = ""
        }
        
        if let position = json["Position"] as? String {
            self.position = position
        } else {
            self.position = ""
        }
        
        if let age = Int((json["Age"] as? String)!) {
            self.age = age
        } else {
            self.age = 0
        }
        
        if let height = json["Height"] as? String {
            self.height = height
        } else {
            self.height = ""
        }
        
        if let school = json["School"] as? String {
            self.school = school
        } else {
            self.school = ""
        }
        
        if let jerseyNumber = Int((json["JerseyNumber"] as? String)!) {
            self.jerseyNumber = jerseyNumber
        } else {
            self.jerseyNumber = 0
        }
    }
}
