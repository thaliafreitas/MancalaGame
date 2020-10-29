//
//  House.swift
//  MancalaGame
//
//  Created by Thalia on 29/10/20.
//  Copyright © 2020 Thalia. All rights reserved.
//
import Foundation

class House {
    
    private var seeds: Int

    public init(seeds: Int) {
        self.seeds = seeds
    }

    public func activate() {
        seeds = 0
    }
}
