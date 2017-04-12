//
//  AddGameViewController.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 4/11/17.
//  Copyright © 2017 Connor Fitzpatrick. All rights reserved.
//

import UIKit

class AddGameViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tournamentName: UITextField!
    @IBOutlet weak var gameNumber: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var opponent: UITextField!
    @IBOutlet weak var gameTime: UIDatePicker!
    @IBOutlet weak var addGameLabel: UIButton!
    
    @IBAction func addGame(_ sender: UIButton) {
    }
    
    @IBOutlet weak var schedule: UITableView!
    
    // MARK: - Variables
    
    var games: [GameFinder] = []
    
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

extension AddGameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schedule", for: indexPath) as! GameTableViewCell
        
        let game = games[(indexPath as NSIndexPath).row]
        cell.configure(game)
        
        return cell
    }
}
