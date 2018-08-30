//
//  Player.swift
//  CoachCoach
//
//  Created by Minsoo Matthew Shin on 2018-05-19.
//  Copyright © 2018 Minsoo Shin. All rights reserved.
//

import Foundation
import RealmSwift

class Player: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var number : Int = 0
    
    @objc dynamic var onField : Bool = false
    
    // position -1 is a player not assigned a position and position 0 is the goalkeeper.
    @objc dynamic var position : Int = -1
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
}
