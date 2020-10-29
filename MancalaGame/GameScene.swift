//
//  GameScene.swift
//  MancalaGame
//
//  Created by Thalia on 28/10/20.
//  Copyright © 2020 Thalia. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let restartLabel: SKLabelNode = {
        let node = SKLabelNode(fontNamed: "AvenirNext-Bold")
        node.text = "RESTART"
        node.fontSize = 50
        node.alpha = 0
        node.horizontalAlignmentMode = .left
        return node
    }()
    
    let quitLabel: SKLabelNode = {
        let node = SKLabelNode(fontNamed: "AvenirNext-Bold")
        node.text = "QUIT"
        node.fontSize = 50
        node.alpha = 0
        node.horizontalAlignmentMode = .left
        return node
    }()
    
    let winnerLabel = SKLabelNode()

    var red = 18 {
        didSet {
            if red == 0 {
                SCKManager.shared.socket.emit("end", 0)
            }
        }
    }
    
    
    var blue = 18 {
        didSet {
            if blue == 0 {
                SCKManager.shared.socket.emit("end", 1)
            }
        }
    }
    

    var nickname: String? {
        return UserDefaults.standard.string(forKey: "nickname")
    }
    
    var player: Player!
    var seeds: Seed! = nil
    var canPlay: Bool!
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        initialSetup()
        
        SCKManager.shared.socket.on("userConnectUpdate") { (data, _) in
            let player = Player(data: data[0] as! [String : AnyObject])
            if player.nickname == self.nickname {
                self.player = player
                self.canPlay = player.number == 0
            }
        }
        
        SCKManager.shared.socket.on("players") { (data, _) in
            let players = (data[0] as? [[String: AnyObject]])?.map(Player.init)
            if players?.count == 2 {
                self.restartLabel.alpha = 1
                self.quitLabel.alpha = 1
            } else {
                self.initialSetup()
            }
        }
        
        
        SCKManager.shared.socket.on("winner") { (data, _) in
            let winner = data[0] as! Int
            if self.player.number == winner {
                self.winnerLabel.text = "YOU WON THE GAME!"
            } else {
                self.winnerLabel.text = "YOU LOST THE GAME!"
            }
        }
        
        SCKManager.shared.getGameMovement { (move) in
            if let move = move {
                self.canPlay.toggle()
                
                self.apply(move: move)
            }
        }
        
        SCKManager.shared.socket.on("restart") { (_, _) in
            self.restart()
        }
        
        SCKManager.shared.socket.on("userExitUpdate") { (data, _) in
            if let quitter = data[0] as? String, quitter != self.nickname {
                self.canPlay = true
                self.player.number = 0
            } else {
                self.canPlay = true
                self.player.number = 1
            }
        }
    }
    
    func initialSetup() {
        self.removeAllChildren()
        winnerLabel.position = CGPoint(x: frame.midX, y: frame.maxY/1.25)
        addChild(winnerLabel)

        restartLabel.position = CGPoint(x: frame.minX/1.1, y: frame.maxY/1.25)
        addChild(restartLabel)

        quitLabel.position = CGPoint(x: frame.minX/1.1, y: frame.maxY/1.5)
        addChild(quitLabel)
    }
    
    func restart() {
        self.initialSetup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let position = touches.first?.location(in: self) else { return }
        
        if self.nodes(at: position).first == restartLabel {
            SCKManager.shared.socket.emit("restart", true)
            return
        }
        
        if self.nodes(at: position).first == quitLabel {
            SCKManager.shared.socket.emit("exit", self.player.nickname)
            self.initialSetup()
            return
        }
        guard canPlay == true else {
            return
        }
        
        // logica do jogo
    }
    
    func apply(move: Move) {
        // fazer os movimentos
    }
}


