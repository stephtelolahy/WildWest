//
//  StatsViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 15/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import RxSwift

class AgressivityStat {
    let source: String
    let target: String
    var value: Int
    
    init(source: String, target: String, value: Int) {
        self.source = source
        self.target = target
        self.value = value
    }
}

class StatsViewController: UITableViewController, Subscribable {
    
    var stateSubject: BehaviorSubject<GameStateProtocol>?
    var stats: [AgressivityStat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "StatCell")
        
        guard let stateSubject = self.stateSubject else {
            return
        }
        
        sub(stateSubject.subscribe(onNext: { [weak self] state in
            self?.stats = state.buildStats()
            self?.tableView.reloadData()
        }))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatCell", for: indexPath)
        let agressivity = stats[indexPath.row]
        cell.textLabel?.text = "\(agressivity.source)->\(agressivity.target) : \(agressivity.value)"
        return cell
    }
}

private extension GameStateProtocol {
    
    func buildStats() -> [AgressivityStat] {
        
        let allPlayers = players + eliminated
        guard let sheriff = allPlayers.first(where: { $0.role == .sheriff }) else {
            return []
        }
        
        let otherPlayers = allPlayers.filter { $0.role != .sheriff }
        let stats = otherPlayers.map { AgressivityStat(source: $0.identifier, target: sheriff.identifier, value: 0) }
        
        moves.forEach { move in
            
            if let bang = move as? Bang {
                appendStrongAttack(from: bang.actorId, to: bang.targetId, in: stats)
            }
            
            if let duel = move as? Duel {
                appendStrongAttack(from: duel.actorId, to: duel.targetId, in: stats)
            }
            
            if let jail = move as? Jail {
                appendWeakAttack(from: jail.actorId, to: jail.targetId, in: stats)
            }
            
            if let panic = move as? Panic {
                if case let .inPlay(cardId) = panic.target.source, cardId.contains("jail") {
                    appendHelp(from: panic.actorId, to: panic.target.ownerId, in: stats)
                } else {
                    appendWeakAttack(from: panic.actorId, to: panic.target.ownerId, in: stats)
                }
            }
            
            if let catBalou = move as? CatBalou {
                if case let .inPlay(cardId) = catBalou.target.source, cardId.contains("jail") {
                    appendHelp(from: catBalou.actorId, to: catBalou.target.ownerId, in: stats)
                } else {
                    appendWeakAttack(from: catBalou.actorId, to: catBalou.target.ownerId, in: stats)
                }
            }
        }
        
        return stats.sorted(by: { $0.value > $1.value })
    }
    
    func appendStrongAttack(from actorId: String, to targetId: String, in stats: [AgressivityStat]) {
        stats.first(where: { $0.source == actorId && $0.target == targetId })?.value += Score.strongAttackEnemy
    }
    
    func appendWeakAttack(from actorId: String, to targetId: String, in stats: [AgressivityStat]) {
        stats.first(where: { $0.source == actorId && $0.target == targetId })?.value += Score.weakAttackEnemy
    }
    
    func appendHelp(from actorId: String, to targetId: String, in stats: [AgressivityStat]) {
        stats.first(where: { $0.source == actorId && $0.target == targetId })?.value += Score.helpEnemy
    }
}
