//
//  ChatViewController.swift
//  MancalaGame
//
//  Created by Thalia on 28/10/20.
//  Copyright © 2020 Thalia. All rights reserved.
//

import Foundation

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var nickname: String!
    
    var players = [Player]()
    
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MessageTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "message-cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SCKManager.shared.getChatMessage { (message) in
            DispatchQueue.main.async {
                self.messages.append(message)
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func send(_ sender: Any) {
        if !textField.text!.isEmpty, let message = textField.text {
            SCKManager.shared.send(message: message, with: nickname)
            textField.text = nil
            textField.resignFirstResponder()
        }
    }
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "message-cell") as! MessageTableViewCell
        let message = messages[indexPath.row]
        cell.messageLabel.text = message.content
        
        let player = players.first { $0.nickname == message.sender }
        
        cell.balloonView.backgroundColor = player!.number == 0 ? .systemBlue : .systemRed
        
        if message.sender == nickname {
            cell.leadingConstraint.isActive = false
            cell.trailingConstraint.isActive = true
        } else {
            cell.leadingConstraint.isActive = true
            cell.trailingConstraint.isActive = false
        }
        
        return cell
    }
}
