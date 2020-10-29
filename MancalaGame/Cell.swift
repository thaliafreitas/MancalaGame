//
//  Cell.swift
//  MancalaGame
//
//  Created by Thalia on 29/10/20.
//  Copyright © 2020 Thalia. All rights reserved.
//

import UIKit

class Cell: Codable {
    var position: Int
    var rotation: CGFloat
    
    
    var color: UIColor {
        let c1 = UIColor.systemGray3
        let c2 = UIColor.systemGray6
        return rotation == 0 ? c1 : c2
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.position = try values.decode(Int.self, forKey: .position)
        self.rotation = try values.decode(CGFloat.self, forKey: .rotation)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(position, forKey: .position)
        try container.encode(rotation, forKey: .rotation)
    }
    
    enum CodingKeys: String, CodingKey {
        case rotation
        case position
    }
}
