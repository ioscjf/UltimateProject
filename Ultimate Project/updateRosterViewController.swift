//
//  updateRosterViewController.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 10/6/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class updateRosterViewController: UIViewController {

    // MARK: - Outlets
    
    @IBAction func addPlayer(_ sender: UIButton) {
        let done = createPlayer()
        if done {
            let p = PlayerFinder(json: playerDict as Dictionary<String, AnyObject>)
            JsonParser.jsonClient.addPlayer(player: p!) {[weak self] in
                DispatchQueue.main.async(execute: {
                    let defaults = UserDefaults.standard
                    
                    let twitter = defaults.object(forKey: "twitterHandle") as? String
                    let team = defaults.object(forKey: "team") as? String
                    
                    JsonParser.jsonClient.getMyPlayer(team: team!, twitter: twitter!) {[weak self](myPlayers) in
                        self?.players = myPlayers
                        
                        DispatchQueue.main.async(execute: {
                            self?.playersTable.reloadData()
                        })
                    }
                })
            }
        } else {
            alert()
        }
    }
    
    @IBOutlet weak var addPlayer: UIButton!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var nickname: UITextField!
    @IBOutlet weak var jerseyNumber: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var cutterHandlerText: UILabel!
    @IBOutlet weak var cutterHandlerSwitch: UISwitch!
    @IBOutlet weak var birthday: UIDatePicker!
    @IBOutlet weak var heightFeet: UITextField!
    @IBOutlet weak var heightInches: UITextField!
    @IBOutlet weak var playersTable: UITableView!
    
    @IBAction func cutterHandlerSwitch(_ sender: UISwitch) {
        if cutterHandlerSwitch.isOn {
            cutterHandlerText.text = "Cutter"
        } else {
            cutterHandlerText.text = "Handler"
        }
    }
    
    // MARK: - Variables
    
    var activeTextField = UITextField()
    var playerDict: [String: AnyObject] = [:]
    var players: [PlayerFinder] = []
    
    @IBOutlet weak var currentRoster: UITableView!

    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDoneButton()
        
        let defaults = UserDefaults.standard
        
        let twitter = defaults.object(forKey: "twitterHandle") as? String
        let team = defaults.object(forKey: "team") as? String
        
        JsonParser.jsonClient.getMyPlayer(team: team!, twitter: twitter!) {[weak self](myPlayers) in
            self?.players = myPlayers
            
            DispatchQueue.main.async(execute: {
                self?.playersTable.reloadData()
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
    
    func alert() {
        let alert = UIAlertController(title: "Oops!", message: "Please fill out all of the fields.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            // perhaps use action.title here
        })
        self.present(alert, animated: true)
    }
    
    func doneTyping() {
        if firstName.text != "" && lastName.text != "" && nickname.text != "" && jerseyNumber.text != "" && weight.text != "" && heightFeet.text != "" && heightInches.text != "" {
            addPlayer.alpha = 1.0
        }
    }
}

extension updateRosterViewController: UITextFieldDelegate {
    
    func addDoneButton() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        weight.inputAccessoryView = keyboardToolbar
        jerseyNumber.inputAccessoryView = keyboardToolbar
        heightFeet.inputAccessoryView = keyboardToolbar
        heightInches.inputAccessoryView = keyboardToolbar
    }
    
    func createPlayer() -> Bool {
        if firstName.text != "" && lastName.text != "" && nickname.text != "" && jerseyNumber.text != "" && weight.text != "" && heightInches.text != "" && heightFeet.text != "" {
            
            if let fn = firstName.text {
                playerDict["nameFirst"] = fn as AnyObject
            } else {
                print("FN")
            }
            
            if let ln = lastName.text {
                playerDict["nameLast"] = ln as AnyObject
            } else {
                print("LN")
            }
            
            if let nn = nickname.text {
                playerDict["nickname"] = nn as AnyObject
            } else {
                print("NN")
            }
            
            if let jn = jerseyNumber.text {
                playerDict["jerseyNum"] = jn as AnyObject
            } else {
                print("JN")
            }
            
            if let w = weight.text {
                playerDict["weight"] = w as AnyObject
            } else {
                print("W")
            }
            
            if let hf = heightFeet.text {
                if let hi = heightInches.text {
                    playerDict["height"] = "\((Int(hf)! * 12) + (Int(hi)!))" as AnyObject
                } else {
                    print("HI")
                }
            } else {
                print("HF")
            }
            
            if let p = cutterHandlerText.text {
                playerDict["position"] = p as AnyObject
            } else {
                print("P")
            }
            
            playerDict["birthday"] = birthday.date as AnyObject
            
            return true
        } else {
            return false
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // TextField should begin editing method
        self.activeTextField = textField
        doneTyping()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // While entering the characters this method gets called
        self.activeTextField = textField
        doneTyping()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // TextField should return method
        self.activeTextField = textField
        textField.resignFirstResponder();
        doneTyping()
        return true;
    }
}

extension updateRosterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rosterplayercell", for: indexPath) as! NewPlayerTableViewCell
        
        let player = players[(indexPath as NSIndexPath).row]
        cell.configure(player)
        
        return cell
    }
}
