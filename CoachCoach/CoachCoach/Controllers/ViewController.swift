//
//  ViewController.swift
//  CoachCoach
//
//  Created by Minsoo Matthew Shin on 2018-04-03.
//  Copyright © 2018 Minsoo Shin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var goalKeeperNameLabel: UILabel!
    @IBOutlet weak var player1NameLabel: UILabel!
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var player3NameLabel: UILabel!
    @IBOutlet weak var player4NameLabel: UILabel!
    @IBOutlet weak var player5NameLabel: UILabel!
    @IBOutlet weak var player6NameLabel: UILabel!
    @IBOutlet weak var player7NameLabel: UILabel!
    @IBOutlet weak var player8NameLabel: UILabel!
    @IBOutlet weak var player9NameLabel: UILabel!
    @IBOutlet weak var player10NameLabel: UILabel!
    
    @IBOutlet weak var goalKeeperView: UIView!
    
    @IBOutlet weak var playerNameListTableView: UITableView!
    
    var playerArray = [Player]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Players.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPlayers()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // load CoachCoach logo here
        
        // delegate table view to self here
        playerNameListTableView.delegate = self
        playerNameListTableView.dataSource = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
        tap.delegate = self
        
        // tap gesture recognizers
        goalKeeperView.addGestureRecognizer(tap)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK - TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerNameCell", for: indexPath)
        
        cell.textLabel?.text = playerArray[indexPath.row].playerName
        
        return cell
    }
    
    //MARK - TableView Delegate Methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    //MARK - Add/Delete Button Functionality
    
    @IBAction func addPlayerButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "New Player", message: "Enter in the name of your player", preferredStyle: .alert)
        
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (okAction) in
            
            let newPlayer = Player()
            newPlayer.playerName = textField.text!
            
            self.playerArray.append(newPlayer)
            self.playerNameListTableView.reloadData()
            
            self.savePlayers()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        alert.addTextField { (playerNameTextField) in
            playerNameTextField.placeholder = "John Smith"
            textField = playerNameTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func deletePlayerButtonPressed(_ sender: Any) {
        
        
    }
    
    //MARK - Model Manipulation Methods
    
    func savePlayers(){
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(playerArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding Player Array: \(error)")
            
        }
        
    }
    
    func loadPlayers(){
        
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data(contentsOf: dataFilePath!)
            playerArray = try decoder.decode([Player].self, from: data)
        } catch {
            print("Error decoding Player Array: \(error)")
        }
    
        
    }
    
    @objc func tap(_ gestureRecognizer: UITapGestureRecognizer) {
        goalKeeperView.alpha = 0.5
    }
    
    
    

}

