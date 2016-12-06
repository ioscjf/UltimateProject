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
    
    @IBAction func save(_ sender: UIButton) {
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var playerNumber: UITextField!
    @IBOutlet weak var playerPosition: UITextField!
    @IBOutlet weak var playerAge: UITextField!
    @IBOutlet weak var playerHeight: UITextField!
    @IBOutlet weak var playerSchool: UITextField!
    
    // MARK: - Variables
    
    var playerDict: [String: AnyObject] = [:]
    var activeTextField = UITextField()
    
    @IBAction func addPlayer(_ sender: UIButton) {

        let p = PlayerFinder(json: playerDict as Dictionary<String, AnyObject>)
        JsonParser.jsonClient.addPlayer(player: p!)
        
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBOutlet weak var currentRoster: UITableView!

    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playerName.delegate = self
        playerNumber.delegate = self
        playerNumber.keyboardType = UIKeyboardType.numberPad // NOTE: Additional support needed for iPad
        playerPosition.delegate = self
        playerAge.delegate = self
        playerAge.keyboardType = UIKeyboardType.numberPad // NOTE: Additional support needed for iPad
        playerHeight.delegate = self
        playerHeight.keyboardType = UIKeyboardType.numberPad // NOTE: Additional support needed for iPad
        playerSchool.delegate = self
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

extension updateRosterViewController: UITextFieldDelegate {
    
    func createPlayer() { // else cases handle nil input
        if let name = playerName.text {
            playerDict["Name"] = name as AnyObject!
        } else {
            playerDict["Name"] = "" as AnyObject!
        }
        
        if let position = playerPosition.text {
            playerDict["Position"] = position as AnyObject!
        } else {
            playerDict["Position"] = "" as AnyObject!
        }
        
        if let age = playerAge.text {
            playerDict["Age"] = age as AnyObject!
        } else {
            playerDict["Age"] = 0 as AnyObject!
        }
        
        if let height = playerHeight.text {
            playerDict["Height"] = height as AnyObject!
        } else {
            playerDict["Height"] = 0 as AnyObject!
        }
        
        if let school = playerSchool.text {
            playerDict["School"] = school as AnyObject!
        } else {
            playerDict["School"] = "" as AnyObject!
        }
    
        if let jerseyNumber = playerNumber.text {
            playerDict["JerseyNumber"] = jerseyNumber as AnyObject!
        } else {
            playerDict["JerseyNumber"] = 0 as AnyObject!
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // TextField should begin editing method
        self.activeTextField = textField
        createPlayer()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // While entering the characters this method gets called
        self.activeTextField = textField
        createPlayer()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // TextField should return method
        self.activeTextField = textField
        createPlayer()
        textField.resignFirstResponder();
        return true;
    }
}
