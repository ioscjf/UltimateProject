//
//  MyGamesTableViewCell.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 4/30/17.
//  Copyright © 2017 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class MyGamesTableViewCell: UITableViewCell {
    
    // MARK - Outlets
    
    @IBOutlet weak var opponent: UILabel!
    @IBOutlet weak var tournament: UILabel!
    @IBOutlet weak var gameNum: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var date: UILabel!
    
    // MARK: - Configuration
    
    func configure(_ game: GameFinder) {
        opponent.text = "\(game.opponent!)"
        date.text = "\(game.date!)"
        tournament.text = "\(game.tournament!)"
        gameNum.text = "\(game.gameNum!)"
        location.text = "\(game.location!)"
    }
}
