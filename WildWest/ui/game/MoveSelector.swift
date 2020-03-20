//
//  MoveSelector.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

protocol MoveSelector {
    func selectMove(within moves: [GameMove], completion: @escaping (GameMove) -> Void)
}

extension MoveSelector where Self: UIViewController {
    
    func selectMove(within moves: [GameMove], completion: @escaping (GameMove) -> Void) {
        guard !moves.isEmpty else {
            return
        }
        
        if moves.contains(where: { $0.targetId != nil }) {
            selectPlayer(within: moves, completion: completion)
            return
        }
        
        if moves.contains(where: { $0.targetCard != nil }) {
            selectTargetCard(within: moves, completion: completion)
            return
        }
        
        if moves.contains(where: { $0.name == .chooseCard }) {
            selectCard(within: moves, completion: completion)
            return
        }
        
        if moves.count == 1,
            let uniqueMove = moves.first {
            completion(uniqueMove)
            return
        }
        
        if moves.contains(where: { $0.discardedCardIds != nil }) {
            selectCardsCombination(within: moves, completion: completion)
            return
        }
        
        select(within: moves.map { $0.name.rawValue }, title: "Select option") { index in
            completion(moves[index])
        }
    }
    
    private func selectPlayer(within moves: [GameMove], completion: @escaping (GameMove) -> Void) {
        let targetIds = moves.compactMap { $0.targetId }
        select(within: targetIds, title: "Select player") { index in
            completion(moves[index])
        }
    }
    
    private func selectTargetCard(within moves: [GameMove], completion: @escaping (GameMove) -> Void) {
        let targets = moves.compactMap { $0.targetCard?.description }
        select(within: targets, title: "Select target card") { index in
            completion(moves[index])
        }
    }
    
    private func selectCard(within moves: [GameMove], completion: @escaping (GameMove) -> Void) {
        let cardIds = moves.compactMap { $0.cardId }
        select(within: cardIds, title: "Select card") { index in
            completion(moves[index])
        }
    }
    
    private func selectCardsCombination(within moves: [GameMove], completion: @escaping (GameMove) -> Void) {
        let cardsCombinations = moves.compactMap { $0.discardedCardIds?.joined(separator: ", ") }
        select(within: cardsCombinations, title: "Select cards") { index in
            completion(moves[index])
        }
    }
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

extension TargetCard {
    var description: String {
        switch source {
        case .randomHand:
            return "\(ownerId)'s random hand"
        case let .inPlay(targetCardId):
            return "\(ownerId)'s \(targetCardId)"
        }
    }
}
