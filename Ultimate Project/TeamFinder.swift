//
//  TeamFinderModel.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 11/8/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import Foundation

struct TeamFinder {
        
    var teamName: String?
    var school: String?
    var division: String?
    var state: String?
    var region: String?
    var conference: String?
    var twitterHandle: String?
    var genderDivision: String?
    var city: String?
    var password: String?
    
    init?(json: Dictionary<String, AnyObject>) {
        if let team = json["teamName"] as? String {
            self.teamName = team
        } else {
            self.teamName = ""
        }
        
        if let school = json["school"] as? String {
            self.school = school
        } else {
            self.school = ""
        }
        
        if let division = json["competitionDivision"] as? String {
            self.division = division
        } else {
            self.division = ""
        }
        
        if let gender = json["genderDivision"] as? String {
            self.genderDivision = gender
        } else {
            self.genderDivision = ""
        }
        
        if let state = json["state"] as? String {
            self.state = state
        } else {
            self.state = ""
        }
        
        if let region = json["region"] as? String {
            self.region = region
        } else {
            self.region = ""
        }
        
        if let conference = json["conference"] as? String {
            self.conference = conference
        } else {
            self.conference = ""
        }
        
        if let city = json["city"] as? String {
            self.city = city
        } else {
            self.city = ""
        }
        
        if let twitter = json["twitterHandle"] as? String {
            self.twitterHandle = twitter
        } else {
            self.twitterHandle = ""
        }
        
        if let pass = json["password"] as? String {
            self.password = pass
        } else {
            self.password = ""
        }
    }
}
