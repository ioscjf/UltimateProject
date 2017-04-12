//
//  StatTrackViewController.swift
//  Ultimate Project
//
//  Created by Connor Fitzpatrick on 10/11/16.
//  Copyright © 2016 Connor Fitzpatrick. All rights reserved.
//

import UIKit
import TwitterKit

class StatTrackViewController: UIViewController {
    
    // MARK: - Variables
    
    // MARK: - Outlets
    
    @IBAction func exit(_ sender: UIBarButtonItem) {
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func playerAction(_ sender: UIButton) {
    }
    
    @IBOutlet weak var teamOneName: UILabel!
    @IBOutlet weak var teamTwoName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var cap: UILabel!
    
    @IBOutlet weak var player1: UIButton! { didSet {
        player1.setTitle("player", for: .normal)
        }
    }
        
    @IBOutlet weak var player2: UIButton!
    @IBOutlet weak var player3: UIButton!
    @IBOutlet weak var player4: UIButton!
    @IBOutlet weak var player5: UIButton!
    @IBOutlet weak var player6: UIButton!
    @IBOutlet weak var player7: UIButton!
    @IBOutlet weak var opponent: UIButton!
    
    @IBAction func score(_ sender: UIButton) {
        tweet()
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
    
    func tweet() {
        // Swift
        let composer = TWTRComposer()
        
        composer.setText("just setting up my Fabric")
        composer.setImage(UIImage(named: "fabric"))
        
        // Called from a UIViewController
        composer.show(from: self) { result in
            if (result == TWTRComposerResult.cancelled) {
                print("Tweet composition cancelled")
            }
            else {
                print("Sending tweet!")
            }
        }
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
