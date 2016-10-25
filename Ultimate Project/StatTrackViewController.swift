//
//  StatTrackViewController.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 10/11/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class StatTrackViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBAction func exit(_ sender: UIBarButtonItem) {
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBOutlet weak var teamOneName: UILabel!
    @IBOutlet weak var teamTwoName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var cap: UILabel!
    
    @IBOutlet weak var rosterATable: UITableView!
    @IBOutlet weak var rosterBTable: UITableView!
    
    @IBAction func score(_ sender: UIButton) {
    }
    
    @IBAction func passingFoul(_ sender: UIButton) {
    }
    
    @IBAction func recievingFoul(_ sender: UIButton) {
    }
    
    @IBAction func undo(_ sender: UIButton) {
    }
    
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
