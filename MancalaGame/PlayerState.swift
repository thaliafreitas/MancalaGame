//
//  PlayerState.swift
//  MancalaGame
//
//  Created by Thalia on 29/10/20.
//  Copyright © 2020 Thalia. All rights reserved.
//

struct PlayerState {
    
    var houses: [House]
    var home: House
    var active: Bool = true

    init(houses: Int, seeds: Int) {
        self.houses = [House](repeating: House(seeds: seeds),
                              count: houses)
        self.home = House(seeds: seeds)
    }
}
