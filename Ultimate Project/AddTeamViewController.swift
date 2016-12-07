//
//  AddTeamViewController.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 12/6/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//
import UIKit

class AddTeamViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func createTeam(_ sender: UIBarButtonItem) {
        
        let t = TeamFinder(json: teamDict as Dictionary<String, AnyObject>)
        JsonParser.jsonClient.addTeam(team: t!)
        
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: nil)
        }
        
        //self.performSegue(withIdentifier: "createTeam", sender: sender) // NOTE: This will probably need to be implemented instead of dismissing the presentingViewController so that when a user logs in with his team, he is immediately signed in (instead of being forced to do so manually)
    }
    
    @IBOutlet weak var teamName: UITextField!
    @IBOutlet weak var school: UITextField!
    @IBOutlet weak var competitionDivision: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var region: UITextField!
    @IBOutlet weak var conference: UITextField!
    
    // MARK - Variables
    
    var teamDict: [String: AnyObject] = [:]
    var activeTextField = UITextField()
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamName.delegate = self
        school.delegate = self
        competitionDivision.delegate = self
        year.delegate = self
        year.keyboardType = UIKeyboardType.numberPad // NOTE: Addtional support needed for iPad
        state.delegate = self
        region.delegate = self
        conference.delegate = self
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
        
        if segue.identifier == "createTeam" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let tbvc = destinationNavigationController.topViewController as!TeamBioViewController
            
            tbvc.teamName = teamDict["TeamName"] as! String
        }
    }
}

extension AddTeamViewController: UITextFieldDelegate {
    
    func createTeam() { // else cases handle nil input
        if let name = teamName.text {
            teamDict["TeamName"] = name as AnyObject!
        } else {
            teamDict["TeamName"] = "" as AnyObject!
        }
        
        if let school = school.text {
            teamDict["School"] = school as AnyObject!
        } else {
            teamDict["School"] = "" as AnyObject!
        }
        
        if let competitionDivision = competitionDivision.text {
            teamDict["CompetitionDivision"] = competitionDivision as AnyObject!
        } else {
            teamDict["CompetitionDivision"] = "" as AnyObject!
        }
        
        if let year = year.text {
            teamDict["Year"] = year as AnyObject!
        } else {
            teamDict["Year"] = 0 as AnyObject!
        }
        
        if let state = state.text {
            teamDict["State"] = state as AnyObject!
        } else {
            teamDict["State"] = "" as AnyObject!
        }
        
        if let region = region.text {
            teamDict["Region"] = region as AnyObject!
        } else {
            teamDict["Region"] = "" as AnyObject!
        }
        
        if let conference = conference.text {
            teamDict["Conference"] = conference as AnyObject!
        } else {
            teamDict["Conference"] = "" as AnyObject!
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // TextField should begin editing method
        self.activeTextField = textField
        createTeam()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // While entering the characters this method gets called
        self.activeTextField = textField
        createTeam()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // TextField should return method
        self.activeTextField = textField
        createTeam()
        textField.resignFirstResponder();
        return true;
    }
}
