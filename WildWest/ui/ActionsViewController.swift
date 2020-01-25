//
//  ActionsViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

protocol ActionsViewControllerDelegate: NSObjectProtocol {
    func actionsViewController(_ controller: ActionsViewController, didSelect action: ActionProtocol)
}

class ActionsViewController: UITableViewController {
    
    var actions: [ActionProtocol] = []
    
    weak var delegate: ActionsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ActionCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell", for: indexPath)
        cell.textLabel?.text = actions[indexPath.row].message
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.actionsViewController(self, didSelect: actions[indexPath.row])
        dismiss(animated: true)
    }
}
