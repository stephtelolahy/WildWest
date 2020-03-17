//
//  StatsViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 15/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import RxSwift

class StatsViewController: UITableViewController, Subscribable {
    
    var stateSubject: BehaviorSubject<GameStateProtocol>?
    private var stats: [AgressivityStat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "StatCell")
        
        guard let stateSubject = self.stateSubject else {
            return
        }
        
        sub(stateSubject.subscribe(onNext: { [weak self] state in
            self?.stats = state.buildAntiSheriffStats()
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
    
    func buildAntiSheriffStats() -> [AgressivityStat] {
        let allPlayers = players + eliminated
        guard let sheriff = allPlayers.first(where: { $0.role == .sheriff }) else {
            return []
        }
        
        let otherPlayers = allPlayers.filter { $0.role != .sheriff }
        var stats = otherPlayers.map { AgressivityStat(source: $0.identifier, target: sheriff.identifier, value: 0) }
        
        let classifier = MoveClassifier()
        executedMoves.forEach { move in
            
            let classification = classifier.classify(move)
            switch classification {
            case let .strongAttack(actorId, targetId):
                stats.append(Score.strongAttackEnemy, from: actorId, to: targetId)
                
            case let .weakAttack(actorId, targetId):
                stats.append(Score.weakAttackEnemy, from: actorId, to: targetId)
                
            case let .help(actorId, targetId):
                stats.append(Score.helpEnemy, from: actorId, to: targetId)
                
            default:
                break
            }
        }
        
        return stats.sorted(by: { $0.value > $1.value })
    }
}

private class AgressivityStat {
    let source: String
    let target: String
    var value: Int
    
    init(source: String, target: String, value: Int) {
        self.source = source
        self.target = target
        self.value = value
    }
}

private extension Array where Element == AgressivityStat {
    
    mutating func append(_ value: Int, from actorId: String, to targetId: String) {
        first(where: { $0.source == actorId && $0.target == targetId })?.value += value
    }
}
