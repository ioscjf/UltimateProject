//
//  StatsTableViewCell.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 12/1/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class StatsTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var scores: UILabel!
    @IBOutlet weak var assists: UILabel!
    @IBOutlet weak var offensivePointsPlayed: UILabel!
    @IBOutlet weak var defensivePointsPlayed: UILabel!
    @IBOutlet weak var drops: UILabel!
    @IBOutlet weak var catches: UILabel!
    @IBOutlet weak var completions: UILabel!
    
    // MARK: - Configuration
    
    func configure(_ stat: StatFinder) {
        playerName.text = "Player: \(stat.playerName!)"
        year.text = "Year: \(stat.year!)"
        scores.text = "Scores: \(stat.scores!)"
        assists.text = "Assists: \(stat.assists!)"
        offensivePointsPlayed.text = "Offensive Points Played: \(stat.offensivePointsPlayed!)"
        defensivePointsPlayed.text = "Defensive Points Played: \(stat.defensivePointsPlayed!)"
        drops.text = "Drops: \(stat.drops!)"
        catches.text = "Catches: \(stat.catches!)"
        completions.text = "Completions: \(stat.completions!)"
    }
}
