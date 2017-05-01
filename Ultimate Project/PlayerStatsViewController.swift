//
//  PlayerStatsViewController.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 10/11/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class PlayerStatsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBOutlet weak var statsTable: UITableView!
    @IBOutlet weak var somePlayerName: UINavigationItem!
    
    // MARK: - Variables
    
    var stats: [StatFinder] = []
    var nameFirst = ""
    var nameLast = ""
    var team = ""
    var opponent = ""
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        
        somePlayerName.title = "\(nameFirst) \(nameLast)"
        
        JsonParser.jsonClient.getStatsFromPlayer(nameFirst: nameFirst, nameLast: nameLast, opponent: opponent, teamName: team) {[weak self](myStats) in
            self?.stats = myStats
            
            DispatchQueue.main.async(execute: {
                self?.statsTable.reloadData()
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

extension PlayerStatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statcell", for: indexPath) as! StatsTableViewCell
        
        let stat = stats[(indexPath as NSIndexPath).row]
        cell.configure(stat)
        
        return cell
    }
}
