//
//  House.swift
//  MancalaGame
//
//  Created by Thalia on 29/10/20.
//  Copyright © 2020 Thalia. All rights reserved.
//

import Foundation

class House {
    var seeds: Int

    init(seeds: Int) {
        self.seeds = seeds
    }

    func activate() {
        seeds = 0
    }
}
