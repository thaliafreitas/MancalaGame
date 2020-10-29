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
    
//    var board = Board(contentsOf: Bundle.main.url(forResource: "board", withExtension: "json")!)!

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
    
    
//    var selectedPiece: Piece! = nil
//    
//    var highlightedCells: [Cell] = []
    
    var nickname: String? {
        return UserDefaults.standard.string(forKey: "nickname")
    }
    
    var player: Player!
    
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
//                self.board.placePieces(at: self)
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
        
//        self.board = Board(contentsOf: Bundle.main.url(forResource: "board", withExtension: "json")!)!
//
//        board.placeCells(at: self)
    }
    
    func restart() {
        self.initialSetup()
//        board.placePieces(at: self)
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
        
        guard canPlay == true else { return }
        
//        if selectedPiece != nil {
//            if let destination = highlightedCells.first(where: { $0.node.contains(position)} ) {
//                let origin = board.cell(at: selectedPiece.position)
//                SCKManager.shared.send(movement: .init(nickname: nickname!, from: origin!, to: destination))
//                selectedPiece = nil
//                clearHighlightedCell()
//            }
//        } else {
//            guard let piece = board.piece(at: position) else { return }
//            guard piece.number == player.number else { return }
//            self.selectedPiece = piece
//            let selectedCell = board.cell(at: position)!
//            selectedCell.neighbors.forEach { (cell) in
//                if !cell.hasPiece && cell.color == selectedCell.color {
//                    cell.isHightlighted = true
//                    self.highlightedCells.append(cell)
//                } else {
//                    cell.isHightlighted = false
//                }
//            }
//
//        }

    }
    
    func apply(move: Move) {
        
//        let origin = board.cells.first(where: { $0.row == move.from.row && $0.column ==  move.from.column })!
//        let destination = board.cells.first(where: { $0.row == move.to.row && $0.column ==  move.to.column })!
//
//        let piece = board.piece(at: origin.node.position)!
        
//        piece.position = destination.node.centroid
//
//        origin.hasPiece = false
//        destination.hasPiece = true
        
//        checkPieces()
        
    }
    

}

func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
    return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
}

