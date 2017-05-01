//
//  MyPlayersViewController.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 4/30/17.
//  Copyright © 2017 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class MyPlayersViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var playerTable: UITableView!
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBOutlet weak var teamName: UINavigationItem!
    
    // MARK: - Variables
    
    var players: [PlayerFinder] = []
    var nameFirst = ""
    var nameLast = ""
    var team = ""
    
    var twitter = ""
    var opponent = ""
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        teamName.title = team

        JsonParser.jsonClient.getPlayerFromGame(team: team, twitter: twitter, opponent: opponent) {[weak self](myPlayers) in
            self?.players = myPlayers
            
            DispatchQueue.main.async(execute: {
                self?.playerTable.reloadData()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "playerToStat" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let psvc = destinationNavigationController.topViewController as! PlayerStatsViewController
            
            psvc.nameFirst = nameFirst
            psvc.nameLast = nameLast
            psvc.team = team
            psvc.opponent = opponent
        }
    }
}

extension MyPlayersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(players)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "workcell", for: indexPath) as! MyPlayerTableViewCell
        let player = players[(indexPath as NSIndexPath).row]
        cell.configure(player)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if players.count > indexPath.row {
            nameFirst = players[indexPath.row].nameFirst!
            nameLast = players[indexPath.row].nameLast!
        }
        self.performSegue(withIdentifier: "playerToStat", sender: indexPath);
    }
}
