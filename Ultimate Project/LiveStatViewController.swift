//
//  LiveStatViewController.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 4/28/17.
//  Copyright © 2017 Connor Fitzpatrick. All rights reserved.
//

import UIKit
import TwitterKit

class LiveStatViewController: UIViewController {
    
    // MARK: - Variables
    
    var statDict: [String: AnyObject] = [:]
    var nameFirst: String = ""
    var nameLast: String = ""
    var players: [PlayerFinder] = []
    var opponent: String = ""
    var path: IndexPath?
    
    // MARK: - Outlets
    
    @IBOutlet weak var myTeam: UITableView!
    @IBOutlet var statButton: [UIButton]!
    
    @IBAction func statAction(_ sender: UIButton) {
        for button in statButton {
            if button.currentTitle == sender.currentTitle {
                if button.backgroundColor == UIColor.blue {
                    button.backgroundColor = UIColor.white
                } else {
                    button.backgroundColor = UIColor.blue
                }
            }
        }
    }
    
    @IBAction func addStat(_ sender: UIButton) {
        if nameFirst == "" || nameLast == "" {
            alert()
        } else {
            statDict["nameFirst"] = nameFirst as AnyObject
            statDict["nameLast"] = nameLast as AnyObject
            for button in statButton {
                let index = getStringFromButtonName(buttonName: button.currentTitle!)
                if button.backgroundColor == UIColor.blue {
                    statDict[index] = "1" as AnyObject
                } else {
                    statDict[index] = "0" as AnyObject
                }
            }
        }
        
        let s = StatFinder(json: statDict as Dictionary<String, AnyObject>)
        JsonParser.jsonClient.addStats(playerNameFirst: nameFirst, playerNameLast: nameLast, opponent: opponent, stat: s!)
        
        reset(path: path!)
    }
    
    @IBAction func tweet(_ sender: UIBarButtonItem) {
        let composer = TWTRComposer()
    
        // Called from a UIViewController
        composer.show(from: self) { result in
            if (result == TWTRComposerResult.cancelled) {
                print("Tweet composition cancelled")
            } else {
                print("Sending tweet!")
            }
        }
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        
        let team = defaults.object(forKey: "team") as! String
        let twitter = defaults.object(forKey: "twitterHandle") as! String
        
        
        JsonParser.jsonClient.getMyPlayer(team: team, twitter: twitter) {[weak self](myPlayers) in
            self?.players = myPlayers
            DispatchQueue.main.async(execute: {
                self?.myTeam.reloadData()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alert() {
        let alert = UIAlertController(title: "Oops!", message: "Please select a player.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            // perhaps use action.title here
        })
        self.present(alert, animated: true)
    }
    
    func reset(path: IndexPath) {
        myTeam.deselectRow(at: path, animated: true)
        for button in statButton {
            button.backgroundColor = UIColor.white
        }
    }
    
    func getStringFromButtonName(buttonName: String) -> String {
        switch buttonName {
            case "Score": return "scores"
            case "Completion": return "completions"
            case "Pull": return "pulls"
            case "Throwing Error": return "throwingErrors"
            case "Drop": return "drops"
            case "D": return "ds"
            case "Offensive Points Played": return "offensivePointsPlayed"
            case "Assist": return "assists"
            case "Foul": return "fouls"
            case "Pulls Out of Bounds": return "pullsOutOfBounds"
            case "Goalline Throwing Error": return "goallineThrowingErrors"
            case "Goalline Drop": return "goallineDrops"
            case "Goalline D": return "goallineDs"
            case "Defensive Points Played": return "defensivePointsPlayed"
        default:
            print("ERROR: WRONG BUTTON NAME")
            return ""
        }
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

extension LiveStatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count =  players.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statplayer", for: indexPath) as! StatPlayerTableViewCell
            
        let player = players[(indexPath as NSIndexPath).row]
        cell.configure(player)
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nameFirst = "\(players[indexPath.row].nameFirst!)"
        nameLast = "\(players[indexPath.row].nameLast!)"
        path = indexPath
    }
}
