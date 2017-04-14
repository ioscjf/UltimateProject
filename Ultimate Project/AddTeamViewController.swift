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
    @IBAction func create(_ sender: UIButton) {
        let done = teamCheck()
        if done {

            let t = TeamFinder(json: teamDict as Dictionary<String, AnyObject>)
            JsonParser.jsonClient.addTeam(team: t!)
        
            self.performSegue(withIdentifier: "CreateOrEditTeam", sender: sender)
        } else {
            alert()
        }
    }
    
    @IBOutlet weak var teamName: UITextField!
    @IBOutlet weak var twitterHandle: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var school: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var region: UITextField!
    @IBOutlet weak var conference: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var genderDivision: UITextField!
    @IBOutlet weak var competitionDivision: UITextField!
    @IBOutlet weak var createLabel: UIButton!
    
    // MARK - Variables
    
    var teamDict: [String: AnyObject] = [:]
    var activeTextField = UITextField()
    var team: String = ""
    var pass: String = ""
    var twitter: String = ""
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
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
        }
    }
    
    func alert() {
        let alert = UIAlertController(title: "Oops!", message: "The Team Name, Twitter Handle, and Password are required fields.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            // perhaps use action.title here
        })
        self.present(alert, animated: true)
    }
    
    func doneTyping() {
        if teamName.text != "" && password.text != "" && twitterHandle.text != "" && school.text != "" && competitionDivision.text != "" && state.text != "" && region.text != "" && conference.text != "" && genderDivision.text != "" && city.text != "" {
            createLabel.alpha = 1.0
        }
    }
}

extension AddTeamViewController: UITextFieldDelegate {
    func createTeam() { // else cases handle nil input
        if let name = teamName.text {
            teamDict["teamName"] = name as AnyObject!
        } else {
            teamDict["teamName"] = "" as AnyObject!
        }
        
        if let school = school.text {
            teamDict["school"] = school as AnyObject!
        } else {
            teamDict["school"] = "" as AnyObject!
        }
        
        if let competitionDivision = competitionDivision.text {
            teamDict["division"] = competitionDivision as AnyObject!
        } else {
            teamDict["division"] = "" as AnyObject!
        }
        
        if let state = state.text {
            teamDict["state"] = state as AnyObject!
        } else {
            teamDict["state"] = "" as AnyObject!
        }
        
        if let region = region.text {
            teamDict["region"] = region as AnyObject!
        } else {
            teamDict["region"] = "" as AnyObject!
        }
        
        if let twitter = twitterHandle.text {
            teamDict["twitterHandle"] = twitter as AnyObject!
        } else {
            teamDict["twitterHandle"] = "" as AnyObject!
        }
        
        if let conference = conference.text {
            teamDict["conference"] = conference as AnyObject!
        } else {
            teamDict["conference"] = "" as AnyObject!
        }
        
        if let gender = genderDivision.text {
            teamDict["genderDivision"] = gender as AnyObject!
        } else {
            teamDict["genderDivision"] = "" as AnyObject!
        }
        
        if let city = city.text {
            teamDict["city"] = city as AnyObject!
        } else {
            teamDict["city"] = "" as AnyObject!
        }
        
        if let password = password.text {
            teamDict["password"] = password as AnyObject!
        } else {
            teamDict["password"] = "" as AnyObject!
        }
    }
    
    func addDoneButton() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        teamName.inputAccessoryView = keyboardToolbar
        password.inputAccessoryView = keyboardToolbar
        school.inputAccessoryView = keyboardToolbar
        competitionDivision.inputAccessoryView = keyboardToolbar
        state.inputAccessoryView = keyboardToolbar
        region.inputAccessoryView = keyboardToolbar
        twitterHandle.inputAccessoryView = keyboardToolbar
        conference.inputAccessoryView = keyboardToolbar
        genderDivision.inputAccessoryView = keyboardToolbar
        city.inputAccessoryView = keyboardToolbar
        password.inputAccessoryView = keyboardToolbar
    }
    
    func teamCheck() -> Bool {
        if teamName.text != "" && password.text != "" && twitterHandle.text != "" {
            
            if let t = teamName.text {
                team = t
            } else {
                print("T")
            }
            
            if let p = password.text {
                pass = p
            } else {
                print("P")
            }
            
            if let tw = twitterHandle.text {
                twitter = tw
            } else {
                print("TW")
            }
            
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

