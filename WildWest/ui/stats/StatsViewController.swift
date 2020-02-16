//
//  StatsViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 15/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import RxSwift

struct GameEvent {
    let name: String
    let occurences: Int
}

class StatsViewController: UITableViewController, Subscribable {
    
    var stateSubject: BehaviorSubject<GameStateProtocol>?
    var events: [GameEvent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ActionCell")
        
        guard let stateSubject = self.stateSubject else {
            return
        }
        
        sub(stateSubject.subscribe(onNext: { [weak self] state in
            self?.events = state.buildStats()
            self?.tableView.reloadData()
        }))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell", for: indexPath)
        let event = events[indexPath.row]
        cell.textLabel?.text = "\(event.name) : \(event.occurences)"
        return cell
    }
}

extension GameStateProtocol {
    // swiftlint:disable function_body_length
    // swiftlint:disable line_length
    func buildStats() -> [GameEvent] {
        return [
            GameEvent(name: "startTurn", occurences: commandsHistory.filter { $0 is StartTurn }.count),
            GameEvent(name: "beer", occurences: commandsHistory.filter { $0 is Beer }.count),
            GameEvent(name: "saloon", occurences: commandsHistory.filter { $0 is Saloon }.count),
            GameEvent(name: "stagecoach", occurences: commandsHistory.filter { $0 is Stagecoach }.count),
            GameEvent(name: "wellsFargo", occurences: commandsHistory.filter { $0 is WellsFargo }.count),
            GameEvent(name: "catBalou", occurences: commandsHistory.filter { $0 is CatBalou }.count),
            GameEvent(name: "panic", occurences: commandsHistory.filter { $0 is Panic }.count),
            GameEvent(name: "bang", occurences: commandsHistory.filter { $0 is Bang }.count),
            GameEvent(name: "missed", occurences: commandsHistory.filter { $0 is Missed }.count),
            GameEvent(name: "gatling", occurences: commandsHistory.filter { $0 is Gatling }.count),
            GameEvent(name: "indians", occurences: commandsHistory.filter { $0 is Indians }.count),
            GameEvent(name: "duel", occurences: commandsHistory.filter { $0 is Duel }.count),
            GameEvent(name: "generalStore", occurences: commandsHistory.filter { $0 is GeneralStore }.count),
            GameEvent(name: "looseLife1", occurences: commandsHistory.filter { ($0 as? LooseLife)?.points == 1 }.count),
            GameEvent(name: "looseLife3", occurences: commandsHistory.filter { ($0 as? LooseLife)?.points == 3 }.count),
            GameEvent(name: "discardBang", occurences: commandsHistory.filter { $0 is DiscardBang }.count),
            GameEvent(name: "discardBeer1", occurences: commandsHistory.filter { ($0 as? DiscardBeer)?.cardsToDiscardIds.count == 1 }.count),
            GameEvent(name: "discardBeer2", occurences: commandsHistory.filter { ($0 as? DiscardBeer)?.cardsToDiscardIds.count == 2 }.count),
            GameEvent(name: "discardBeer3", occurences: commandsHistory.filter { ($0 as? DiscardBeer)?.cardsToDiscardIds.count == 3 }.count),
            GameEvent(name: "jail", occurences: commandsHistory.filter { $0 is Jail }.count),
            GameEvent(name: "resolveJail", occurences: commandsHistory.filter { $0 is ResolveJail }.count),
            GameEvent(name: "resolveDynamite", occurences: commandsHistory.filter { $0 is ResolveDynamite }.count),
            GameEvent(name: "resolveBarrel", occurences: commandsHistory.filter { $0 is ResolveBarrel }.count),
            GameEvent(name: "volcanic", occurences: commandsHistory.filter { ($0 as? Equip)?.cardId.contains("volcanic") == true }.count),
            GameEvent(name: "schofield", occurences: commandsHistory.filter { ($0 as? Equip)?.cardId.contains("schofield") == true }.count),
            GameEvent(name: "remington", occurences: commandsHistory.filter { ($0 as? Equip)?.cardId.contains("remington") == true }.count),
            GameEvent(name: "winchester", occurences: commandsHistory.filter { ($0 as? Equip)?.cardId.contains("winchester") == true }.count),
            GameEvent(name: "revCarbine", occurences: commandsHistory.filter { ($0 as? Equip)?.cardId.contains("revCarbine") == true }.count),
            GameEvent(name: "mustang", occurences: commandsHistory.filter { ($0 as? Equip)?.cardId.contains("mustang") == true }.count),
            GameEvent(name: "scope", occurences: commandsHistory.filter { ($0 as? Equip)?.cardId.contains("scope") == true }.count),
            GameEvent(name: "barrel", occurences: commandsHistory.filter { ($0 as? Equip)?.cardId.contains("barrel") == true }.count),
            GameEvent(name: "dynamite", occurences: commandsHistory.filter { ($0 as? Equip)?.cardId.contains("dynamite") == true }.count)
        ]
        .sorted(by: { $0.occurences > $1.occurences })
    }
}
