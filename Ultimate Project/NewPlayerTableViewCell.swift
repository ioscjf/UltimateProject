//
//  NewPlayerTableViewCell.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 4/27/17.
//  Copyright © 2017 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class NewPlayerTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var playerName: UILabel!

    // MARK: - Configuration
    
    func configure(_ player: PlayerFinder) {
        playerName.text = "\(player.nameFirst!) \(player.nameLast!)"
        position.text = "\(player.position!)"
        playerNumber.text = "\(player.jerseyNum!)"
    }
}
