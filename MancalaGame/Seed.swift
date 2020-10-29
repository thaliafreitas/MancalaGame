//
//  Seed.swift
//  MancalaGame
//
//  Created by Thalia on 29/10/20.
//  Copyright © 2020 Thalia. All rights reserved.
//

import SpriteKit

class Seed: SKShapeNode {
   
   var number: Int
   
   init(color: UIColor, isCaptain: Bool, number: Int) {
       self.number = number
       super.init()
       self.strokeColor = .clear
       self.fillColor = color
       self.path = SKShapeNode(circleOfRadius: 100).path
   }
   
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
}
