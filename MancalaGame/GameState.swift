//
//  GameState.swift
//  MancalaGame
//
//  Created by Thalia on 29/10/20.
//  Copyright © 2020 Thalia. All rights reserved.
//

import Foundation

struct GameState: CustomStringConvertible{
    var players: [PlayerState]

    init(houses: Int, seeds: Int, players: Int) {
        self.players = [PlayerState](repeating: PlayerState(houses: houses, seeds: seeds),
                                     count: players)
    }

    public var description: String {
        return "GameState"
    }
}
