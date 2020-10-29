//
//  PlayerTableViewCell.swift
//  MancalaGame
//
//  Created by Thalia on 29/10/20.
//  Copyright © 2020 Thalia. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var statusView: UIView!

     override func awakeFromNib() {
            super.awakeFromNib()
            self.selectionStyle = .none
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        
    }

    extension PlayerTableViewCell {
        public func configure(with player: Player) {
            self.nicknameLabel.text = player.nickname
            self.statusView.backgroundColor = player.number == 0 ? .systemBlue : .systemRed
            self.statusView.alpha = player.isConnected ? 1.0 : 0.5
        }
        
    }
