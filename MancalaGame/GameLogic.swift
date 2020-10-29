//
//  GameLogic.swift
//  MancalaGame
//
//  Created by Thalia on 29/10/20.
//  Copyright © 2020 Thalia. All rights reserved.
//

import Foundation

func game(houses: Int, seeds: Int, players: Int) {
    var gameShouldContinue = true

    let controllers = (0...(players - 1)).map({i in PlayersViewController(playerIndex: i)})
    let state = GameState(houses: houses, seeds: seeds, players: players)
    let game = MancalaGameMode(state: state, players: controllers)

    while gameShouldContinue {
        game.step()

        let won = game.won()
        if won != nil {
            gameShouldContinue = false
        }
    }
}
