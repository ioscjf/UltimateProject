//
//  PlayerTableViewCell.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 12/1/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var position: UILabel!
    
    // MARK: - Configuration

    func configure(_ player: PlayerFinder) {
        playerName.text = "\(player.nameFirst!) \(player.nameLast!)"
        position.text = "Position: \(player.position!)"
        playerNumber.text = "Jersey Number: \(player.jerseyNum!)"
    }
}
