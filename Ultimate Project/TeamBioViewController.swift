//
//  TeamBioViewController.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 10/6/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import UIKit
import TwitterKit

class TeamBioViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var roster: UITableView!
    @IBOutlet weak var schedule: UITableView!
    @IBOutlet weak var twitterHandle: UIButton!
    
    @IBAction func showTweets(_ sender: UIButton) {
        showTimeline()
    }
    
    @IBAction func logout(_ sender: UIButton) {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
        performSegue(withIdentifier: "logout", sender: self)
    }
    
    
    // MARK: - Variables
    
    var players: [PlayerFinder] = []
    var myTeam: TeamFinder?
    var games: [GameFinder] = []
    var opponent: String = ""
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        let defaults = UserDefaults.standard
        
        let team = defaults.object(forKey: "team") as! String
        let twitter = defaults.object(forKey: "twitterHandle") as! String
        
        twitterHandle.setTitle("@\(twitter)", for: .normal)
        
        JsonParser.jsonClient.getMyPlayer(team: team, twitter: twitter) {[weak self](myPlayers) in
            self?.players = myPlayers
            DispatchQueue.main.async(execute: {
                self?.roster.reloadData()
            })
        }
        
        JsonParser.jsonClient.getMyGames(team: team, twitter: twitter) {[weak self](myGames) in
            self?.games = myGames
            DispatchQueue.main.async(execute: {
                self?.schedule.reloadData()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alert() {
        let alert = UIAlertController(title: "Oops!", message: "You need at least 7 players to start a game.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            // perhaps use action.title here
        })
        self.present(alert, animated: true)
    }
    
    func showTimeline() {
        
        let defaults = UserDefaults.standard
        let twitter = defaults.object(forKey: "twitterHandle") as! String
        
        let userID = Twitter.sharedInstance().sessionStore.session()?.userID
        let client = TWTRAPIClient(userID: userID)
        let dataSource = TWTRUserTimelineDataSource(screenName: twitter, apiClient: client)
        
        let timelineViewControlller = TWTRTimelineViewController(dataSource: dataSource)
        // Create done button to dismiss the view controller
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissTimeline))
        timelineViewControlller.navigationItem.leftBarButtonItem = button
        // Create a navigation controller to hold the
        let navigationController = UINavigationController(rootViewController: timelineViewControlller)
        showDetailViewController(navigationController, sender: self)
    }
    func dismissTimeline() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "livestats" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let lsvc = destinationNavigationController.topViewController as! LiveStatViewController
            
            lsvc.opponent = opponent
        }
    }
}

extension TeamBioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if tableView == self.roster {
            count =  players.count
        } else if tableView == self.schedule {
            count = games.count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.roster {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loginplayercell", for: indexPath) as! PlayerTableViewCell
            
            let player = players[(indexPath as NSIndexPath).row]
            cell.configure(player)
            
            return cell
        } else { // should be schedule
            let cell = tableView.dequeueReusableCell(withIdentifier: "schedule", for: indexPath) as! GameTableViewCell
            
            let game = games[(indexPath as NSIndexPath).row]
            cell.configure(game)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.schedule {
            if players.count > 6 {
                if games.count > indexPath.row {
                    opponent = games[indexPath.row].opponent!
                }
                tableView.deselectRow(at: indexPath, animated: true)
                self.performSegue(withIdentifier: "livestats", sender: self)
            } else {
                alert()
            }
        }
    }
}
