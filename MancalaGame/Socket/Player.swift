//
//  Player.swift
//  MancalaGame
//
//  Created by Thalia on 28/10/20.
//  Copyright © 2020 Thalia. All rights reserved.
//

import Foundation

struct Player: Hashable {
    
    let identifier = UUID()
    var number: Int
    let nickname: String
    let isConnected: Bool
    
    init(data: [String: AnyObject]) {
        self.number = data["number"] as! Int
        self.nickname = data["nickname"] as! String
        self.isConnected = data["isConnected"] as! Bool
    }
    
}

