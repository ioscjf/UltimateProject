//
//  MyPlayerTableViewCell.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 4/30/17.
//  Copyright © 2017 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class MyPlayerTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var jerseyNum: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    
    // MARK: - Configuration
    
    func configure(_ player: PlayerFinder) {
        playerName.text = "\(player.nameFirst!) \(player.nameLast!)"
        position.text = "\(player.position!)"
        jerseyNum.text = "#\(player.jerseyNum!)"
        nickname.text = "\(player.nickname!)"
        birthday.text = "\(player.birthday!)"
        height.text = "\(player.heightFeet!)' \(player.heightInches!)''"
        weight.text = "\(player.weight!) lbs."
    }
}
