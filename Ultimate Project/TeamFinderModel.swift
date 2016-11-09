//
//  TeamFinderModel.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 11/8/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import Foundation

class TeamFinderModel: NSObject {
    
    //properties
    
    var team: String?
    var school: String?
    var division: String?
    var year: String?
    var state: String?
    var region: String?
    var conference: String?
    
    //empty constructor
    
    override init() {}
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(team: String, school: String, division: String, year: String, state: String, region: String, conference: String) {
        
        self.team = team
        self.school = school
        self.division = division
        self.year = year
        self.state = state
        self.region = region
        self.conference = conference
        
    }
    
    override var description: String {
        return "Team: \(team), School: \(school), Division: \(division), Year: \(year), State: \(state), Region: \(region), Conference: \(conference)"
    }
}
