//
//  StatPlayerTableViewCell.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 4/28/17.
//  Copyright © 2017 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class StatPlayerTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var position: UILabel!
    
    // MARK: - Configuration
    
    func configure(_ player: PlayerFinder) {
        playerName.text = "\(player.nameFirst!) \(player.nameLast!)"
        position.text = "\(player.position!)"
        playerNumber.text = "\(player.jerseyNum!)"
    }
}
