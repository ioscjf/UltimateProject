//
//  NewGameTableViewCell.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 4/27/17.
//  Copyright © 2017 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class NewGameTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var opponentName: UILabel!
    @IBOutlet weak var date: UILabel!

    // MARK: - Configuration
    
    func configure(_ game: GameFinder) {
        opponentName.text = "\(game.opponent!)"
        date.text = "\(game.date!)"
    }
}
