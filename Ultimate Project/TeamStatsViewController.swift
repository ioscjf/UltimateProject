//
//  TeamStatsViewController.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 10/11/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class TeamStatsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBOutlet weak var someTeamName: UINavigationItem!
    @IBOutlet weak var opponentsTable: UITableView!
    
    // MARK: - Variables
    
    var games: [GameFinder] = []
    var teamName = ""
    var twitter = ""
    
    var opponent = ""
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        someTeamName.title = teamName
        
        JsonParser.jsonClient.getMyGames(team: teamName, twitter: twitter) {[weak self](myGames) in
            self?.games = myGames
            DispatchQueue.main.async(execute: {
                self?.opponentsTable.reloadData()
            })
        }
        
        // myGames -> games all games where team == __
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
        
        if segue.identifier == "gameToPlayer" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let mpvc = destinationNavigationController.topViewController as! MyPlayersViewController
            
            mpvc.team = teamName
            mpvc.twitter = twitter
            mpvc.opponent = opponent
        }
    }
}

extension TeamStatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "opponent", for: indexPath) as! MyGamesTableViewCell
        
        let game = games[(indexPath as NSIndexPath).row]
        cell.configure(game)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if games.count > indexPath.row {
            opponent = games[indexPath.row].opponent!
        }
        self.performSegue(withIdentifier: "gameToPlayer", sender: indexPath);
    }
}
