//
//  PlayersViewController.swift
//  MancalaGame
//
//  Created by Thalia on 28/10/20.
//  Copyright © 2020 Thalia. All rights reserved.
//

import UIKit

typealias PlayerProvider = (UITableView, IndexPath, Player) -> UITableViewCell

class PlayersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var button: UIButton!
    var players = [Player]()
    var playerIndex: Int = 0

    public init(playerIndex: Int) {
        self.playerIndex = playerIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let provider: PlayerProvider = { (tableView, indexPath, player) in
        let cell = tableView.dequeueReusableCell(withIdentifier: "player-cell", for: indexPath) as? PlayerTableViewCell
        cell?.configure(with: player)
        return cell ?? PlayerTableViewCell()
    }
    
    lazy var dataSource = UITableViewDiffableDataSource<Int, Player>(tableView: self.tableView, cellProvider: provider)
    
    var nickname: String? {
        return UserDefaults.standard.string(forKey: "nickname")
    }
    
    var joined = false

    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PlayerTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "player-cell")
        tableView.dataSource = self.dataSource
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView(frame: .zero)
        
        SCKManager.shared.socket.on("userExitUpdate") { (data, _) in
            if let quitter = data[0] as? String, quitter == self.nickname {
                UserDefaults.standard.set(nil, forKey: "nickname")
                self.button.setTitle("JOIN", for: .normal)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

    
//    required init?(coder aDecoder: NSCoder) {
//
//    }

    
    @IBAction func join(_ sender: Any) {
        
        if nickname == nil {
            requestNickname()
            return
        }
        
        let chat = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chat-controller") as! ChatViewController
        
        chat.nickname = nickname
        chat.players = players
        
        addChild(chat)
        
        chat.view.frame = view.bounds
        self.view.addSubview(chat.view)
        
        UIView.transition(from: self.view, to: chat.view, duration: 0.25, options: .transitionCrossDissolve) { _ in
            chat.didMove(toParent: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "chat" {
                let chatViewController = segue.destination as! ChatViewController
                chatViewController.nickname = nickname
            }
        }
    }
    
    func requestNickname() {
        
        let alert = UIAlertController(title: "Mancala", message: "Enter your nickname", preferredStyle: .alert)
     
        alert.addTextField {
            $0.addTarget(self, action: #selector(self.textChanged), for: .editingChanged)
        }
     
        let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            let textfield = alert.textFields![0]
            UserDefaults.standard.set(textfield.text, forKey: "nickname")
            self.button.setTitle("CHAT", for: .normal)
            SCKManager.shared.connectToServer(with: self.nickname!) { (players) in
                DispatchQueue.main.async {
                    if let players = players {
                        self.players = players
                        self.update(with: players)
                    }
                }
            }
        }
        
        action.isEnabled = false

        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func textChanged(_ sender: UITextField) {
        var responder: UIResponder! = sender
        while !(responder is UIAlertController) { responder = responder.next }
        let alert = responder as! UIAlertController
        alert.actions[0].isEnabled = !sender.text!.isEmpty
    }

}

extension PlayersViewController {
    
    private func update(with players: [Player], animated: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Player>()
        snapshot.appendSections([0])
        snapshot.appendItems(players, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
}
