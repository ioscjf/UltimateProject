//
//  TeamFinderViewController.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 10/11/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class TeamFinderViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var teamTable: UITableView!
    
    // MARK: - Variables
    
    var teams: [TeamFinder] = []
    var teamName = ""
    var twitter = ""
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        JsonParser.jsonClient.getTeams { [weak self](teams) in
            self?.teams = teams
            DispatchQueue.main.async(execute: {
            self?.teamTable.reloadData()
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
        
        if segue.identifier == "TeamFinderToTeamPage" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let tsvc = destinationNavigationController.topViewController as! TeamStatsViewController
            
            tsvc.teamName = teamName
            tsvc.twitter = twitter
        }
    }
}

extension TeamFinderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamcell", for: indexPath) as! TeamTableViewCell
        
        let team = teams[(indexPath as NSIndexPath).row]
        cell.configure(team)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if teams.count > indexPath.row {
            teamName = teams[indexPath.row].teamName!
            twitter = teams[indexPath.row].twitterHandle!
        }
        self.performSegue(withIdentifier: "TeamFinderToTeamPage", sender: indexPath);
    }
}
