//
//  LoginViewController.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 10/6/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var teamNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var twitterSignIn: TWTRLogInButton!
    
    @IBAction func signIn(_ sender: UIButton) {
        Twitter.sharedInstance().logIn { session, error in
            if let unwrappedSession = session {
                let defaults = UserDefaults.standard
                defaults.set(unwrappedSession.authToken, forKey: "session")
                defaults.set(unwrappedSession.userName, forKey: "twitterHandle")
                defaults.synchronize()
                
                let done = self.login()
                if done {
                    JsonParser.jsonClient.login(team: self.team, password: self.password) {[weak self](myTeam) in
                        self?.myTeam = myTeam
                        
                        DispatchQueue.main.async(execute: {
                            print("\(unwrappedSession.userName) has logged in")
                            self?.performSegue(withIdentifier: "LoggedIn", sender: nil)
                        })
                    }
                } else {
                    self.alert()
                }
                
            } else {
                print("Login error: %@", error!.localizedDescription)
            }
        }
    }
    
    // MARK: - Variables
    
    var activeTextField = UITextField()
    var team: String = ""
    var password: String = ""
    var myTeam: TeamFinder?
    
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
        if segue.identifier == "LoggedIn" {
//            let defaults = UserDefaults.standard
//
//            let destinationNavigationController = segue.destination as! UITabBarController
//            let tbvc = destinationNavigationController.viewControllers?[0] as!TeamBioViewController
//            tbvc.team = team
//            defaults.set(team, forKey: "team")
//            
//            if let auth = defaults.object(forKey: "twitterHandle") as? String {
//                tbvc.twitter = auth
//            } else {
//                tbvc.twitter = ""
//                print("ERROR: NO TWITTER")
//            }
        }
    }
    
    func alert() {
        let alert = UIAlertController(title: "Oops!", message: "Please fill out all of the fields.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            // perhaps use action.title here
        })
        self.present(alert, animated: true)
    }
    
    func doneTyping() {
        if teamNameTextField.text != "" && passwordTextField.text != "" {
            twitterSignIn.alpha = 1.0
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func addDoneButton() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        teamNameTextField.inputAccessoryView = keyboardToolbar
        passwordTextField.inputAccessoryView = keyboardToolbar
    }
    
    func login() -> Bool {
        if teamNameTextField.text != "" && passwordTextField.text != "" {
            
            if let t = teamNameTextField.text {
                team = t
            } else {
                print("T")
            }
            
            if let p = passwordTextField.text {
                password = p
            } else {
                print("P")
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
