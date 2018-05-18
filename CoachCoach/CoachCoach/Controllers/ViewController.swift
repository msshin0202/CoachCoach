//
//  ViewController.swift
//  CoachCoach
//
//  Created by Minsoo Matthew Shin on 2018-04-03.
//  Copyright © 2018 Minsoo Shin. All rights reserved.
//

import UIKit
import CoreData

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
    
    var selectedPlayer : String = ""
    
    var playerArray = [Player]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Players.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // load CoachCoach logo here
        
        // delegate table view to self here
        playerNameListTableView.delegate = self
        playerNameListTableView.dataSource = self
        
        addTap(viewToAddTapRecognizerTo: goalKeeperView)
        addTap(viewToAddTapRecognizerTo: player1View)
        addTap(viewToAddTapRecognizerTo: player2View)
        addTap(viewToAddTapRecognizerTo: player3View)
        addTap(viewToAddTapRecognizerTo: player4View)
        addTap(viewToAddTapRecognizerTo: player5View)
        addTap(viewToAddTapRecognizerTo: player6View)
        addTap(viewToAddTapRecognizerTo: player7View)
        addTap(viewToAddTapRecognizerTo: player8View)
        addTap(viewToAddTapRecognizerTo: player9View)
        
        print(teamNameLabel.text!)
        loadPlayers()
        teamName()

    }
    
    func teamName(){
        if (teamNameLabel.text == "My Team"){
            var textField = UITextField()
            
            let alert = UIAlertController(title: "Team Name", message: "Enter in the name of your team", preferredStyle: .alert)
            
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { (okAction) in
                
                self.teamNameLabel.text = textField.text!
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.addTextField { (teamNameinTextField) in
                teamNameinTextField.placeholder = "Team Name"
                textField = teamNameinTextField
            }
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func addTap (viewToAddTapRecognizerTo : UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:playerNameLabel:)))
        tap.delegate = self
        viewToAddTapRecognizerTo.addGestureRecognizer(tap)
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
        
        let cell = tableView.cellForRow(at: indexPath)
        selectedPlayer = (cell?.textLabel!.text!)!
        
        
        
    }
    
    //MARK - Add/Delete Button Functionality
    
    @IBAction func addPlayerButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "New Player", message: "Enter in the name of your player", preferredStyle: .alert)
        
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (okAction) in
            
            let newPlayer = Player(context: self.context)
            newPlayer.playerName = textField.text!
            
            self.playerArray.append(newPlayer)
            
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
        
        
        let alert = UIAlertController(title: "Delete Player", message: "Are you sure you want to delete \(selectedPlayer) from your team?" , preferredStyle: .alert)
        
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (deleteAction) in
            
            for player in 0...self.playerArray.count-1 {
                if (self.playerArray[player].playerName! == self.selectedPlayer){
                    self.playerArray.remove(at: player)
                    self.savePlayers()                    
                    return
                }
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    
        
        
        
    }
    
    //MARK - Model Manipulation Methods
    
    func savePlayers(){
        
        do {
            try context.save()

        } catch {
            print("Error saving context: \(error)")
            
        }
        
        playerNameListTableView.reloadData()
        
    }
    
    func loadPlayers(with request : NSFetchRequest<Player> = Player.fetchRequest()){
        
        do {
            playerArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }
    
        
    }
    
    @objc func tap(_ gestureRecognizer: UITapGestureRecognizer, playerNameLabel : UILabel) {
        print("what gets printed here?")
        print("here")
    }
    
    
    

}

