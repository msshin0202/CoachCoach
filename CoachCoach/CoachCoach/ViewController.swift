//
//  ViewController.swift
//  CoachCoach
//
//  Created by Minsoo Matthew Shin on 2018-04-03.
//  Copyright © 2018 Minsoo Shin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    @IBOutlet weak var playerNameListTableView: UITableView!
    
    var playerArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // load CoachCoach logo here
        
        // delegate table view to self here
        playerNameListTableView.delegate = self
        playerNameListTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerNameCell", for: indexPath)
        
        cell.textLabel?.text = playerArray[indexPath.row]
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPlayerButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "New Player", message: "Enter in the name of your player", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            let newPlayerName = alert.textFields?[0].text
            self.playerArray.append(newPlayerName!)
//            self.playerNameListTableView.beginUpdates()
//            self.playerNameListTableView.endUpdates()
            return
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    @IBAction func deletePlayerButtonPressed(_ sender: Any) {
    }
    
    
    

}

