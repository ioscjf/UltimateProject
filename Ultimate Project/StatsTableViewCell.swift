//
//  StatsTableViewCell.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 12/1/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class StatsTableViewCell: UITableViewCell { // TODO!!

    // MARK: - Outlets
    
    @IBOutlet weak var scores: UILabel!
    @IBOutlet weak var assists: UILabel!
    @IBOutlet weak var offensivePointsPlayed: UILabel!
    @IBOutlet weak var defensivePointsPlayed: UILabel!
    @IBOutlet weak var drops: UILabel!
    @IBOutlet weak var completions: UILabel!
    @IBOutlet weak var fouls: UILabel!
    @IBOutlet weak var pulls: UILabel!
    @IBOutlet weak var pullsOutOfBounds: UILabel!
    @IBOutlet weak var throwingErrors: UILabel!
    @IBOutlet weak var goallineThrowingErrors: UILabel!
    @IBOutlet weak var goallineDrops: UILabel!
    @IBOutlet weak var ds: UILabel!
    @IBOutlet weak var goallineDs: UILabel!
    
    // MARK: - Configuration
    
    func configure(_ stat: StatFinder) {
        scores.text = "Scores: \(stat.scores!)"
        assists.text = "Assists: \(stat.assists!)"
        offensivePointsPlayed.text = "Offensive Points Played: \(stat.offensivePointsPlayed!)"
        defensivePointsPlayed.text = "Defensive Points Played: \(stat.defensivePointsPlayed!)"
        drops.text = "Drops: \(stat.drops!)"
        completions.text = "Completions: \(stat.completions!)"
        fouls.text = "Fouls: \(stat.fouls!)"
        pulls.text = "Pulls: \(stat.pulls!)"
        pullsOutOfBounds.text = "Pulls Out of Bounds: \(stat.pullsOutOfBounds!)"
        throwingErrors.text = "Throwing Errors: \(stat.throwingErrors!)"
        goallineThrowingErrors.text = "Goalline Throwing Errors: \(stat.goallineThrowingErrors!)"
        goallineDrops.text = "Goalline Drops: \(stat.goallineDrops!)"
        ds.text = "Ds: \(stat.ds!)"
        goallineDs.text = "Goalline Ds: \(stat.goallineDs!)"
    }
}
