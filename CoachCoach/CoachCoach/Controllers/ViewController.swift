//
//  ViewController.swift
//  CoachCoach
//
//  Created by Minsoo Matthew Shin on 2018-04-03.
//  Copyright © 2018 Minsoo Shin. All rights reserved.
//

import UIKit
import RealmSwift

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerNameCell", for: indexPath)
        if let player = playerNames?[indexPath.row] {
            cell.textLabel?.text = player.name
        } else {
            cell.textLabel?.text = "No Players Added"
        }
        
        return cell
    }
    
    
    //MARK - TableView Delegate Methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedPlayer = Player()
        selectedPlayer?.name = (playerNames?[indexPath.row].name)!
        
        
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
    
    
    @IBAction func deletePlayerButtonPressed(_ sender: Any) {
        

        let alert = UIAlertController(title: "Delete Player", message: "Are you sure you want to delete \(String(describing: selectedPlayer?.name)) from your team?" , preferredStyle: .alert)


        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (deleteAction) in

            self.deletePlayer(player: self.selectedPlayer!)

        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(deleteAction)
        alert.addAction(cancelAction)

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
    
    func deletePlayer(player : Player){
        do {
            try realm.write {
                realm.delete(player)
            }
        } catch {
            print("Error trying to save context: \(error)")
        }
        
        playerNameListTableView.reloadData()
    }

    
    func loadPlayers(){
        
        playerNames = realm.objects(Player.self)
        playerNameListTableView.reloadData()
        
//        goalKeeperNameLabel.text = realm.object(ofType: Player.self, forPrimaryKey: goalKeeperNameLabel.text)?.name
        
        
    }
    
    
    //MARK - Tap Gesture Handlers
    
    func storeFieldPlayer(playerLabel : UILabel){
        
        do{
            try realm.write {
            
                playerLabel.text = selectedPlayer?.name
                playerLabel.sizeToFit()
                
                let newFieldPlayer = Player()
                newFieldPlayer.name = (selectedPlayer?.name)!
                newFieldPlayer.onField = true
                newFieldPlayer.position = playerLabel.tag
                
                realm.add(newFieldPlayer)

                
            }
        } catch {
            print("Error trying to save context: \(error)")
        }
        
    }
    
    @IBAction func goalKeeperTouch(recognizer:UITapGestureRecognizer) {
        storeFieldPlayer(playerLabel: goalKeeperNameLabel)
    }
    
    @IBAction func player1Touch(recognizer:UITapGestureRecognizer){
        storeFieldPlayer(playerLabel: player1NameLabel)
    }
//
//    @IBAction func player2Touch(recognizer:UITapGestureRecognizer){
//        player2NameLabel.text = selectedPlayer
//        player2NameLabel.sizeToFit()
//    }
//
//    @IBAction func player3Touch(recognizer:UITapGestureRecognizer){
//        player3NameLabel.text = selectedPlayer
//        player3NameLabel.sizeToFit()
//    }
//
//    @IBAction func player4Touch(recognizer:UITapGestureRecognizer){
//        player4NameLabel.text = selectedPlayer
//        player4NameLabel.sizeToFit()
//    }
//
//    @IBAction func player5Touch(recognizer:UITapGestureRecognizer){
//        player5NameLabel.text = selectedPlayer
//        player5NameLabel.sizeToFit()
//    }
//
//    @IBAction func player6Touch(recognizer:UITapGestureRecognizer){
//        player6NameLabel.text = selectedPlayer
//        player6NameLabel.sizeToFit()
//    }
//
//    @IBAction func player7Touch(recognizer:UITapGestureRecognizer){
//        player7NameLabel.text = selectedPlayer
//        player7NameLabel.sizeToFit()
//    }
//
//    @IBAction func player8Touch(recognizer:UITapGestureRecognizer){
//        player8NameLabel.text = selectedPlayer
//        player8NameLabel.sizeToFit()
//    }
//
//    @IBAction func player9Touch(recognizer:UITapGestureRecognizer){
//        player9NameLabel.text = selectedPlayer
//        player9NameLabel.sizeToFit()
//    }
//
//    @IBAction func player10Touch(recognizer:UITapGestureRecognizer){
//        player10NameLabel.text = selectedPlayer
//        player10NameLabel.sizeToFit()
//    }
    
    

}

