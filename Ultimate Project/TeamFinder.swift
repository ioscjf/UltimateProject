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
    var year: Int?
    var state: String?
    var region: String?
    var conference: String?
    
    init?(json: Dictionary<String, AnyObject>) {
        if let team = json["TeamName"] as? String {
            self.team = team
        } else {
            self.team = ""
        }
        
        if let school = json["School"] as? String {
            self.school = school
        } else {
            self.school = ""
        }
        
        if let division = json["CompetitionDivision"] as? String {
            self.division = division
        } else {
            self.division = ""
        }
        
        if let year = Int((json["Year"] as? String)!) {
            self.year = year
        } else {
            self.year = 0
        }
        
        if let state = json["State"] as? String {
            self.state = state
        } else {
            self.state = ""
        }
        
        if let region = json["Region"] as? String {
            self.region = region
        } else {
            self.region = ""
        }
        
        if let conference = json["Conference"] as? String {
            self.conference = conference
        } else {
            self.conference = ""
        }
    }
}
