//
//  ViewController.swift
//  CoachCoach
//
//  Created by Minsoo Matthew Shin on 2018-04-03.
//  Copyright © 2018 Minsoo Shin. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    //MARK - IBOutlets
    
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
    @IBOutlet weak var player1View: UIView!
    @IBOutlet weak var player2View: UIView!
    @IBOutlet weak var player3View: UIView!
    @IBOutlet weak var player4View: UIView!
    @IBOutlet weak var player5View: UIView!
    @IBOutlet weak var player6View: UIView!
    @IBOutlet weak var player7View: UIView!
    @IBOutlet weak var player8View: UIView!
    @IBOutlet weak var player9View: UIView!
    @IBOutlet weak var player10View: UIView!
    
    @IBOutlet weak var playerNameListTableView: UITableView!
    
    //MARK - Global variables
    
    var selectedPlayer : Player?
    
    var playerNames : Results<Player>?
    
    var fieldPlayers : Results<Player>?
    
    
    let realm = try! Realm()
    
    
    //MARK - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // load CoachCoach logo here
        
        // delegate table view to self here
        playerNameListTableView.delegate = self
        playerNameListTableView.dataSource = self
        
        loadPlayers()
        
        playerNameListTableView.rowHeight = 88
        
    
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK - TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerNames?.count ?? 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerNameCell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        if let player = playerNames?[indexPath.row] {
            cell.textLabel?.text = player.name
        } else {
            cell.textLabel?.text = "No Players Added"
        }
        
        return cell
    }
    
    
    //MARK - TableView Delegate Methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedPlayer = realm.object(ofType: Player.self, forPrimaryKey: (playerNames?[indexPath.row].name)!)
//        selectedPlayer?.name = (playerNames?[indexPath.row].name)!
        
        
    }
    
    //MARK - Add/Delete Button Functionality
    
    @IBAction func addPlayerButtonPressed(_ sender: Any) {
        
        var nameTextField = UITextField()
        
        let alert = UIAlertController(title: "New Player", message: "Enter in the name of your player", preferredStyle: .alert)
        
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (okAction) in
            
            let newPlayer = Player()
            newPlayer.name = nameTextField.text!
            self.save(player: newPlayer)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        alert.addTextField { (playerNameTextField) in
            playerNameTextField.placeholder = "John Smith"
            nameTextField = playerNameTextField
        }
        
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK - Model Manipulation Methods
    
    func save(player : Player){
        do {
            try realm.write {
                realm.add(player)
            }
        } catch {
            print("Error trying to save context: \(error)")
        }
        
        playerNameListTableView.reloadData()
    }

    
    func loadPlayers(){
        
        playerNames = realm.objects(Player.self)
        playerNameListTableView.reloadData()
        

        for player in playerNames! {
            if player.onField == true {
                switch player.position {
                case 0:
                    goalKeeperNameLabel.text = player.name
                    goalKeeperNameLabel.sizeToFit()
                case 1:
                    player1NameLabel.text = player.name
                    player1NameLabel.sizeToFit()
                case 2:
                    player2NameLabel.text = player.name
                    player2NameLabel.sizeToFit()
                case 3:
                    player3NameLabel.text = player.name
                    player3NameLabel.sizeToFit()
                case 4:
                    player4NameLabel.text = player.name
                    player4NameLabel.sizeToFit()
                case 5:
                    player5NameLabel.text = player.name
                    player5NameLabel.sizeToFit()
                case 6:
                    player6NameLabel.text = player.name
                    player6NameLabel.sizeToFit()
                case 7:
                    player7NameLabel.text = player.name
                    player7NameLabel.sizeToFit()
                case 8:
                    player8NameLabel.text = player.name
                    player8NameLabel.sizeToFit()
                case 9:
                    player9NameLabel.text = player.name
                    player9NameLabel.sizeToFit()
                case 10:
                    player10NameLabel.text = player.name
                    player10NameLabel.sizeToFit()
                default:
                    print("Error loading field players")
                    return
                }
            }
        }
        
        
//        goalKeeperNameLabel.text = realm.object(ofType: Player.self, forPrimaryKey: goalKeeperNameLabel.text)?.name
        
        
    }
    
    
    //MARK - Tap Gesture Handlers
    
    func storeFieldPlayer(playerLabel : UILabel){
        
        do{
            try realm.write {
            
                playerLabel.text = selectedPlayer?.name
                playerLabel.sizeToFit()
        
                let currPlayer = realm.object(ofType: Player.self, forPrimaryKey: playerLabel.text)
                currPlayer?.position = playerLabel.tag
                currPlayer?.onField = true

                
            }
        } catch {
            print("Error trying to save context: \(error)")
        }
        
    }
    
    func updatePlayer() {
        
    }
    
    @IBAction func goalKeeperTouch(recognizer:UITapGestureRecognizer) {
        storeFieldPlayer(playerLabel: goalKeeperNameLabel)
    }
    
    @IBAction func player1Touch(recognizer:UITapGestureRecognizer){
        storeFieldPlayer(playerLabel: player1NameLabel)
    }

    @IBAction func player2Touch(recognizer:UITapGestureRecognizer){
        storeFieldPlayer(playerLabel: player2NameLabel)
    }

    @IBAction func player3Touch(recognizer:UITapGestureRecognizer){
        storeFieldPlayer(playerLabel: player3NameLabel)
    }

    @IBAction func player4Touch(recognizer:UITapGestureRecognizer){
        storeFieldPlayer(playerLabel: player4NameLabel)
    }

    @IBAction func player5Touch(recognizer:UITapGestureRecognizer){
        storeFieldPlayer(playerLabel: player5NameLabel)
    }

    @IBAction func player6Touch(recognizer:UITapGestureRecognizer){
        storeFieldPlayer(playerLabel: player6NameLabel)
    }

    @IBAction func player7Touch(recognizer:UITapGestureRecognizer){
        storeFieldPlayer(playerLabel: player7NameLabel)
    }

    @IBAction func player8Touch(recognizer:UITapGestureRecognizer){
        storeFieldPlayer(playerLabel: player8NameLabel)
    }

    @IBAction func player9Touch(recognizer:UITapGestureRecognizer){
        storeFieldPlayer(playerLabel: player9NameLabel)
    }

    @IBAction func player10Touch(recognizer:UITapGestureRecognizer){
        storeFieldPlayer(playerLabel: player10NameLabel)
    }
    
    

}

//MARK: - Swipe Cell Delegate Methods

extension ViewController : SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            
            if let playerForDeletion = self.playerNames?[indexPath.row]{
                
                do {
                    try self.realm.write {
                        self.realm.delete(playerForDeletion)
                    }
                } catch {
                    print("Error deleting player: \(error)")
                }
            }
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
        
        
    }
}

