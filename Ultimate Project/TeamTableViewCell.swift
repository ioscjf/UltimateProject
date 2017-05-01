//
//  TeamTableViewCell.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 11/10/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var school: UILabel!
    @IBOutlet weak var twitterHandle: UILabel!
    @IBOutlet weak var genderDivision: UILabel!
    @IBOutlet weak var division: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var conference: UILabel!
    @IBOutlet weak var city: UILabel!
    
    // MARK: - Configuration
    
    func configure(_ team: TeamFinder) {
        teamName.text = team.teamName
        school.text = team.school
        twitterHandle.text = "@"+String(describing: team.twitterHandle!)
        genderDivision.text = team.genderDivision
        division.text = team.division
        state.text = team.state
        region.text = team.region
        conference.text = team.conference
        city.text = team.city
    }
}
