//
//  GameViewController.swift
//  MancalaGame
//
//  Created by Thalia on 28/10/20.
//  Copyright © 2020 Thalia. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

protocol Controller {
    func makeMove(state: GameState) -> PlayerMove
}

class GameViewController: UIViewController {

    let skView = SKView()
    let uiView = UIView()

    let scene = GameScene(size: CGSize(width: 800, height: 800))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(skView)
        view.addSubview(uiView)
        setupSKview()
        setupUIview()
    }
    
    private func setupSKview() {
        skView.translatesAutoresizingMaskIntoConstraints = false
        skView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        skView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        skView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        skView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        skView.ignoresSiblingOrder = true
        skView.allowsTransparency = true
        
        skView.presentScene(scene)
        skView.scene?.scaleMode = .aspectFit
        skView.backgroundColor = .clear
        
    }
    
    private func setupUIview() {
        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        uiView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        uiView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        uiView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "players-controller")
        self.addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.uiView.addSubview(controller.view)
        controller.didMove(toParent: self)
        
        controller.view.leadingAnchor.constraint(equalTo: uiView.leadingAnchor).isActive = true
        controller.view.trailingAnchor.constraint(equalTo: uiView.trailingAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: uiView.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: uiView.bottomAnchor).isActive = true
    }
}
