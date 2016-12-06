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
        
        let s = PlayerFinder(json: statDict as Dictionary<String, AnyObject>)
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
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
