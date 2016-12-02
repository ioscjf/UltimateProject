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
    @IBOutlet weak var division: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var conference: UILabel!
    
    // MARK: - Configuration
    
    func configure(_ team: TeamFinder) {
        teamName.text = team.team
        school.text = team.school
        division.text = team.division
        year.text = "\(team.year)"
        state.text = team.state
        region.text = team.region
        conference.text = team.conference
    }
}
