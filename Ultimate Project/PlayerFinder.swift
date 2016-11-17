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
    var age: String?
    var height: String?
    var school: String?
    
    init?(json: Dictionary<String, AnyObject>) {
        guard let name = json["Name"] as? String else {
            return nil
        }
        self.player = name
        
        guard let position = json["Position"] as? String else {
            return nil
        }
        self.position = position
        
        guard let age = json["Age"] as? String else {
            return nil
        }
        self.age = age
        
        guard let height = json["Height"] as? String else {
            return nil
        }
        self.height = height
        
        guard let school = json["School"] as? String else {
            return nil
        }
        self.school = school
    }
}
