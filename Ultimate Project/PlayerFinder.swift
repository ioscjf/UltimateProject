//
//  PlayerFinder.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 11/17/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import Foundation

struct PlayerFinder {
    
    var nameFirst: String?
    var nameLast: String?
    var nickname: String?
    var weight: Int?
    var jerseyNum: Int?
    var heightFeet: Int?
    var heightInches: Int?
    var position: String?
    var birthday: String?
    
    init?(json: Dictionary<String, AnyObject>) {
        
        if let name = json["nameFirst"] as? String {
            self.nameFirst = name
        } else {
            self.nameFirst = ""
        }
        
        if let name = json["nameLast"] as? String {
            self.nameLast = name
        } else {
            self.nameLast = ""
        }
        
        if let pos = json["position"] as? String {
            self.position = pos
        } else {
            self.position = ""
        }
        
        if let weight = Int((json["weight"] as? String)!) {
            self.weight = weight
        } else {
            self.weight = 0
        }
        
        if let jersey = Int((json["jerseyNum"] as? String)!) {
            self.jerseyNum = jersey
        } else {
            self.jerseyNum = 0
        }
        
        if let nick = json["nickname"] as? String {
            self.nickname = nick
        } else {
            self.nickname = ""
        }

        if let birthday = json["birthday"] as? Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            self.birthday = dateFormatter.string(from: birthday)
        } else {
            if let birthday = json["birthday"] as? String {
                self.birthday = birthday
            } else {
                self.birthday = "2017-01-01"
            }
        }
        
        if let height = Int((json["height"] as? String)!) {
            self.heightInches = height % 12
            self.heightFeet = Int(height / 12)
        } else {
            if let hi = json["heightInches"] as? Int {
                self.heightInches = hi
            } else {
                self.heightInches = 0
            }
            if let hf = json["heightFeet"] as? Int {
                self.heightFeet = hf
            } else {
                self.heightFeet = 0
            }
        }
        
    }
}
