//
//  MancalaViewController.swift
//  MancalaGame
//
//  Created by Thalia on 29/10/20.
//  Copyright © 2020 Thalia. All rights reserved.
//

import UIKit

class MancalaGameMode: GameMode {
    private var state: GameState
    private var players: [PlayersViewController]
    private var currentPlayer = 0

    init(state: GameState, players: [PlayersViewController]) {
        self.state = state
        self.players = players

    }

    func processPlayerMove(player: Int, move: PlayerMove) -> GameState {
        return state
    }

    func setNextPlayerActive() {
        currentPlayer = currentPlayer + 1
        if currentPlayer == players.count {
            currentPlayer = 0
        }
    }

    func step() {
        let move = players[currentPlayer].makeMove(state: state)
        state = processPlayerMove(player: currentPlayer, move: move)
        setNextPlayerActive()
    }

    func won() -> Int? {
        return nil
    }
}
