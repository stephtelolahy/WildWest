//
//  MoveSelector.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

protocol MoveSelector {
    func selectMove(within actions: [GameMove], completion: @escaping ((GameMove) -> Void))
}

extension MoveSelector where Self: UIViewController {
    
    func selectMove(within actions: [GameMove], completion: @escaping ((GameMove) -> Void)) {
        /*
        guard !actions.isEmpty else {
            return
        }
        
        if let playCardAgainstOnePlayerActions = actions as? [PlayCardAgainstOnePlayerActionProtocol] {
            selectPlayer(within: playCardAgainstOnePlayerActions, completion: completion)
            return
        }
        
        if let playCardAgainstOneCardActions = actions as? [PlayCardAgainstOneCardActionProtocol] {
            selectTargetCard(within: playCardAgainstOneCardActions, completion: completion)
            return
        }
        
        if let chooseCardActions = actions as? [ChooseCardActionProtocol] {
            selectCard(within: chooseCardActions, completion: completion)
            return
        }
        
        if actions.count == 1,
            let uniqueAction = actions.first {
            completion(uniqueAction)
            return
        }
        
        if let chooseCardsCombinationsActions = actions as? [ChooseCardsCombinationActionProtocol] {
            selectCardsCombination(within: chooseCardsCombinationsActions, completion: completion)
            return
        }
        
        select(within: actions.map { $0.description }, title: "Select option") { index in
            completion(actions[index])
        }
         */
    }
    /*
    private func selectPlayer(within actions: [PlayCardAgainstOnePlayerActionProtocol],
                              completion: @escaping ((ActionProtocol) -> Void)) {
        let targetIds = actions.map { $0.targetId }
        select(within: targetIds, title: "Select player") { index in
            completion(actions[index])
        }
    }
    
    private func selectTargetCard(within actions: [PlayCardAgainstOneCardActionProtocol],
                                  completion: @escaping ((ActionProtocol) -> Void)) {
        let targets = actions.map { $0.target.description }
        select(within: targets, title: "Taget card") { index in
            completion(actions[index])
        }
    }
    
    private func selectCard(within actions: [ChooseCardActionProtocol],
                            completion: @escaping ((ActionProtocol) -> Void)) {
        let cardIds = actions.map { $0.cardId }
        select(within: cardIds, title: "Select card") { index in
            completion(actions[index])
        }
    }
    
    private func selectCardsCombination(within actions: [ChooseCardsCombinationActionProtocol],
                                        completion: @escaping ((ActionProtocol) -> Void)) {
        let cardsCombinations = actions.map { $0.cardIds.joined(separator: ", ") }
        select(within: cardsCombinations, title: "Select cards") { index in
            completion(actions[index])
        }
    }
     */
}

private extension UIViewController {
    func select(within choices: [String], title: String, completion: @escaping((Int) -> Void)) {
        let alertController = UIAlertController(title: title,
                                                message: nil,
                                                preferredStyle: .alert)
        
        choices.forEach { choice in
            alertController.addAction(UIAlertAction(title: choice,
                                                    style: .default,
                                                    handler: { _ in
                                                        guard let index = choices.firstIndex(of: choice) else {
                                                            return
                                                        }
                                                        completion(index)
            }))
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
        
        present(alertController, animated: true)
    }
}

private extension TargetCard {
    var description: String {
        switch source {
        case .randomHand:
            return "\(ownerId)'s random hand"
        case let .inPlay(targetCardId):
            return "\(ownerId)'s \(targetCardId)"
        }
    }
}
