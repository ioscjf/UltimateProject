//
//  GameTableViewCell.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 4/11/17.
//  Copyright © 2017 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var opponentName: UILabel!
    @IBOutlet weak var date: UILabel!
    
    // MARK: - Configuration
    
    func configure(_ game: GameFinder) {
        opponentName.text = "\(game.opponent!)"
        date.text = "\(game.date!)"
    }

}
