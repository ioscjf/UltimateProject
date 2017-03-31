//
//  TeamBioViewController.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 10/6/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class TeamBioViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var roster: UITableView!
    @IBOutlet weak var schedule: UITableView!
    @IBOutlet weak var tweets: UITableView!
    
    // MARK: - Variables
    
    var players: [PlayerFinder] = []
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        JsonParser.jsonClient.getPlayers { [weak self](players) in
            self?.players = players
            DispatchQueue.main.async(execute: {
                self?.roster.reloadData()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TeamBioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "loginplayercell", for: indexPath) as! PlayerTableViewCell
        
        let player = players[(indexPath as NSIndexPath).row]
        cell.configure(player)
        
        return cell
    }
}
