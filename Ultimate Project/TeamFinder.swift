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
        guard let team = json["Team"] as? String else {
            return nil
        }
        self.team = team
        
        guard let school = json["School"] as? String else {
            return nil
        }
        self.school = school
        
        guard let division = json["Division"] as? String else {
            return nil
        }
        self.division = division
        
        guard let year = json["Year"] as? String else {
            return nil
        }
        self.year = year
        
        guard let state = json["State"] as? String else {
            return nil
        }
        self.state = state
        
        guard let region = json["Region"] as? String else {
            return nil
        }
        self.region = region
        
        guard let conference = json["Conference"] as? String else {
            return nil
        }
        self.conference = conference
    }
}
