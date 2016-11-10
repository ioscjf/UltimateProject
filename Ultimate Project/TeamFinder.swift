//
//  TeamFinderModel.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 11/8/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import Foundation

struct TeamFinder {
        
    var team: String?
    var school: String?
    var division: String?
    var year: String?
    var state: String?
    var region: String?
    var conference: String?
    
    init?(json: Dictionary<String, AnyObject>) {
        guard let team = json["team"] as? String else {
            return nil
        }
        self.team = team
        
        guard let school = json["school"] as? String else {
            return nil
        }
        self.school = school
        
        guard let division = json["division"] as? String else {
            return nil
        }
        self.division = division
        
        guard let year = json["year"] as? String else {
            return nil
        }
        self.year = year
        
        guard let state = json["state"] as? String else {
            return nil
        }
        self.state = state
        
        guard let region = json["region"] as? String else {
            return nil
        }
        self.region = region
        
        guard let conference = json["conference"] as? String else {
            return nil
        }
        self.conference = conference
        
        print("HERE")
        print(team, school)
        print("\(team) \(school) \(division) \(year) \(state) \(region) \(conference)")
    }
}
