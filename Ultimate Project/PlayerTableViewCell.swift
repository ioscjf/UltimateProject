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
    
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var school: UILabel!
    
    // MARK: - Configuration

    func configure(_ player: PlayerFinder) {
        playerName.text = "Player: \(player.player!)"
        position.text = "Position: \(player.position!)"
        age.text = "Age: \(player.age!)"
        height.text = "Height: \(player.height!)"
        school.text = "School: \(player.school!)"
    }
}
