//
//  TeamFinderViewController.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 10/11/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class TeamFinderViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var howToSortPicker: UIPickerView!
    @IBOutlet weak var teamTable: UITableView!
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
    }
    
    // MARK: - Variables
    
    private var teams: [TeamFinder] = []
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JsonParser.jsonClient.getTeams { [weak self](teams) in
            self?.teams = teams
            
            print(self?.teams)
            
            DispatchQueue.main.async(execute: {
                
                self?.teamTable.reloadData()
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

}
