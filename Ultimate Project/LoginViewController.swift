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
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBOutlet weak var teamNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func newTeam(_ sender: UIButton) {
    }
    
    @IBOutlet weak var twitterSignIn: TWTRLogInButton!
    
    @IBAction func signIn(_ sender: UIButton) {
        Twitter.sharedInstance().logIn { session, error in
            if let unwrappedSession = session {
                let defaults = UserDefaults.standard
                defaults.set(unwrappedSession.authToken, forKey: "session")
                defaults.synchronize()
                
                print("\(unwrappedSession.userName) has logged in")
                self.performSegue(withIdentifier: "LoggedIn", sender: nil)
            } else {
                print("Login error: %@", error!.localizedDescription)
            }
        }
    }
    
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
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if identifier == "LoggedIn" {
//        }
        return true
    }
}
