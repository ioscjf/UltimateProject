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
        let done = createGame()
        if done {
            let g = GameFinder(json: gameDict as Dictionary<String, AnyObject>)
            JsonParser.jsonClient.addGames(game: g!) {[weak self] in
                DispatchQueue.main.async(execute: {
                    let defaults = UserDefaults.standard
                    
                    let twitter = defaults.object(forKey: "twitterHandle") as? String
                    let team = defaults.object(forKey: "team") as? String
                    
                    JsonParser.jsonClient.getMyGames(team: team!, twitter: twitter!) {[weak self](myGames) in
                        self?.games = myGames
                        
                        DispatchQueue.main.async(execute: {
                            self?.schedule.reloadData()
                        })
                    }
                })
            }
        } else {
            alert()
        }
    }
    
    @IBAction func submit(_ sender: UIButton) {
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
    @IBOutlet weak var schedule: UITableView!
    
    // MARK: - Variables
    
    var games: [GameFinder] = []
    var activeTextField = UITextField()
    var gameDict: [String: AnyObject] = [:]
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDoneButton()
        
        let defaults = UserDefaults.standard

        let team = defaults.object(forKey: "team") as! String
        let twitter = defaults.object(forKey: "twitterHandle") as! String
        
        JsonParser.jsonClient.getMyGames(team: team, twitter: twitter) {[weak self](myGames) in
            self?.games = myGames
            DispatchQueue.main.async(execute: {
                self?.schedule.reloadData()
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
    
    func alert() {
        let alert = UIAlertController(title: "Oops!", message: "Please fill out all of the fields.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            // perhaps use action.title here
        })
        self.present(alert, animated: true)
    }
    
    func doneTyping() {
        if tournamentName.text != "" && gameNumber.text != "" && location.text != "" && opponent.text != "" {
            addGameLabel.alpha = 1.0
        }
    }
}

extension AddGameViewController: UITextFieldDelegate {
        
    func addDoneButton() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
            target: view, action: #selector(UIView.endEditing(_:)))
            keyboardToolbar.items = [flexBarButton, doneBarButton]
            tournamentName.inputAccessoryView = keyboardToolbar
            gameNumber.inputAccessoryView = keyboardToolbar
            location.inputAccessoryView = keyboardToolbar
            opponent.inputAccessoryView = keyboardToolbar
    }

    func createGame() -> Bool {
        if tournamentName.text != "" && gameNumber.text != "" && location.text != "" && opponent.text != "" {
            
            if let tn = tournamentName.text {
                gameDict["tournament"] = tn as AnyObject
            } else {
                print("FN")
            }
            
            if let gn = gameNumber.text {
                gameDict["gameNum"] = gn as AnyObject
            } else {
                print("GN")
            }
            
            if let l = location.text {
                gameDict["location"] = l as AnyObject
            } else {
                print("L")
            }
            
            if let o = opponent.text {
                gameDict["opponent"] = o as AnyObject
            } else {
                print("O")
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from:gameTime.date as Date)
            gameDict["date"] = dateString as AnyObject
            
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

extension AddGameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newgame", for: indexPath) as! NewGameTableViewCell
        
        let game = games[(indexPath as NSIndexPath).row]
        cell.configure(game)
        
        return cell
    }
}
