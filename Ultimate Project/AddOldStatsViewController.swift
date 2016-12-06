//
//  AddOldStatsViewController.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 12/6/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class AddOldStatsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBAction func addStats(_ sender: UIButton) {
        
        let s = StatFinder(json: statDict as Dictionary<String, AnyObject>)
        JsonParser.jsonClient.addStats(stat: s!)
        
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var scores: UITextField!
    @IBOutlet weak var assists: UITextField!
    @IBOutlet weak var offensivePointsPlayed: UITextField!
    @IBOutlet weak var defensivePointsPlayed: UITextField!
    @IBOutlet weak var drops: UITextField!
    @IBOutlet weak var catches: UITextField!
    @IBOutlet weak var completions: UITextField!
    
    // MARK: - Variables
    
    var statDict: [String: AnyObject] = [:]
    var activeTextField = UITextField()
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerName.delegate = self
        year.delegate = self
        year.keyboardType = UIKeyboardType.numberPad // NOTE: Additional support needed for iPad
        scores.delegate = self
        scores.keyboardType = UIKeyboardType.numberPad // NOTE: Additional support needed for iPad
        assists.delegate = self
        assists.keyboardType = UIKeyboardType.numberPad // NOTE: Addtional support needed for iPad
        offensivePointsPlayed.delegate = self
        offensivePointsPlayed.keyboardType = UIKeyboardType.numberPad // NOTE: Additional support needed for iPad
        defensivePointsPlayed.delegate = self
        defensivePointsPlayed.keyboardType = UIKeyboardType.numberPad // NOTE: Addditional support needed for iPad
        drops.delegate = self
        drops.keyboardType = UIKeyboardType.numberPad // NOTE: Additional support needed for iPad
        catches.delegate = self
        catches.keyboardType = UIKeyboardType.numberPad // NOTE: Additional support needed for iPad
        completions.delegate = self
        completions.keyboardType = UIKeyboardType.numberPad // NOTE: Additional support needed for iPad
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

extension AddOldStatsViewController: UITextFieldDelegate {
    
    func createStat() { // else cases handle nil input
        if let name = playerName.text {
            statDict["PlayerName"] = name as AnyObject!
        } else {
            statDict["PlayerName"] = "" as AnyObject!
        }
        
        if let year = year.text {
            statDict["Year"] = year as AnyObject!
        } else {
            statDict["Year"] = 0 as AnyObject!
        }
        
        if let scores = scores.text {
            statDict["Scores"] = scores as AnyObject!
        } else {
            statDict["Scores"] = 0 as AnyObject!
        }
        
        if let assists = assists.text {
            statDict["Assists"] = assists as AnyObject!
        } else {
            statDict["Assists"] = 0 as AnyObject!
        }
        
        if let offensivePointsPlayed = offensivePointsPlayed.text {
            statDict["OffensivePointsPlayed"] = offensivePointsPlayed as AnyObject!
        } else {
            statDict["OffensivePointsPlayed"] = 0 as AnyObject!
        }
        
        if let defensivePointsPlayed = defensivePointsPlayed.text {
            statDict["DefensivePointsPlayed"] = defensivePointsPlayed as AnyObject!
        } else {
            statDict["DefensivePointsPlayed"] = 0 as AnyObject!
        }
        
        if let drops = drops.text {
            statDict["Drops"] = drops as AnyObject!
        } else {
            statDict["Drops"] = 0 as AnyObject!
        }
        
        if let catches = catches.text {
            statDict["Catches"] = catches as AnyObject!
        } else {
            statDict["Catches"] = 0 as AnyObject!
        }
        
        if let completions = completions.text {
            statDict["Completions"] = completions as AnyObject!
        } else {
            statDict["Completions"] = 0 as AnyObject!
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // TextField should begin editing method
        self.activeTextField = textField
        createStat()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // While entering the characters this method gets called
        self.activeTextField = textField
        createStat()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // TextField should return method
        self.activeTextField = textField
        createStat()
        textField.resignFirstResponder();
        return true;
    }
}
