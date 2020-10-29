//
//  GameMode.swift
//  MancalaGame
//
//  Created by Thalia on 29/10/20.
//  Copyright © 2020 Thalia. All rights reserved.
//

import Foundation

protocol GameMode {
    func step()
    func won() -> Int?
}
