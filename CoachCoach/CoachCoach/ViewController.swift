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
//    var rowSelected : Int = 0
//    var iPath : IndexPath = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // load CoachCoach logo here
        
        // delegate table view to self here
        playerNameListTableView.delegate = self
        playerNameListTableView.dataSource = self
        
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
        
        cell.textLabel?.text = playerArray[indexPath.row]
        
        return cell
    }
    
    //MARK - TableView Delegate Methods

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        rowSelected = indexPath.row
//        iPath = indexPath
//    }
    
    //MARK - Add/Delete Button Functionality
    
    @IBAction func addPlayerButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "New Player", message: "Enter in the name of your player", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (okAction) in
            self.playerArray.append(textField.text!)
            self.playerNameListTableView.reloadData()
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
        
        
//        let alert = UIAlertController(title: "Delete Player", message: "Are you sure you want to delete player?", preferredStyle: .alert)
//
//        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (okAction) in
//            self.playerNameListTableView.deleteRows(at: [self.iPath], with: UITableViewRowAnimation.automatic)
//            self.playerArray.remove(at: self.rowSelected)
//            self.playerNameListTableView.reloadData()
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//        alert.addAction(deleteAction)
//        alert.addAction(cancelAction)
//
//        present(alert, animated: true, completion: nil)
    }
    
    
    

}

