//
//  Move.swift
//  MancalaGame
//
//  Created by Thalia on 28/10/20.
//  Copyright © 2020 Thalia. All rights reserved.
//

import Foundation

struct Move: Codable {
    
    var nickname: String
    var from: Coordinate
    var to: Coordinate
    
    struct Coordinate: Codable {
        var pit: Int
    }
    
}

extension Move {
    
    init(nickname: String, from: String, to: String) {
        self.nickname = nickname
        self.from = Coordinate(pit: from.count)
        self.to = Coordinate(pit: to.count)
    }
}
