//
//  CommandsViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 15/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import RxSwift

class CommandsViewController: UITableViewController, Subscribable {
    
    var stateSubject: BehaviorSubject<GameStateProtocol>?
    var actions: [ActionProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ActionCell")
        
        guard let stateSubject = self.stateSubject else {
            return
        }
        
        sub(stateSubject.subscribe(onNext: { [weak self] state in
            self?.actions = state.commands.reversed()
            self?.tableView.reloadData()
        }))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell", for: indexPath)
        cell.textLabel?.text = actions[indexPath.row].description
        return cell
    }
}
