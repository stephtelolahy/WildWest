//
//  PlayMoveSelector.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable function_body_length

import UIKit

protocol PlayMoveSelectorProtocol {
    func selectMove(within moves: [GameMove], completion: @escaping (GameMove) -> Void)
}

class PlayMoveSelector: PlayMoveSelectorProtocol {
    
    private unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func selectMove(within moves: [GameMove], completion: @escaping (GameMove) -> Void) {
        guard !moves.isEmpty else {
            return
        }
        
        if moves.allSatisfy({ $0.targetId != nil }) {
            let targetIds = moves.compactMap { $0.targetId }
            viewController.select(title: "Select player", choices: targetIds) { index in
                completion(moves[index])
            }
            return
        }
        
        if moves.allSatisfy({ $0.targetCard != nil }) {
            let targets = moves.compactMap { $0.targetCard?.description }
            viewController.select(title: "Select target card", choices: targets) { index in
                completion(moves[index])
            }
            return
        }
        
        if moves.allSatisfy({ $0.discardIds != nil }) {
            let options = moves.compactMap { $0.discardIds?.joined(separator: ", ") }
            viewController.select(title: "Select cards to discard", choices: options) { index in
                completion(moves[index])
            }
            return
        }
        
        if moves.count == 1,
            let uniqueMove = moves.first,
            uniqueMove.targetId == nil,
            uniqueMove.targetCard == nil,
            uniqueMove.discardIds == nil {
            completion(uniqueMove)
            return
        }
        
        let choices: [String] = moves.map { $0.cardId ?? $0.name.rawValue }
        viewController.select(title: moves[0].name.rawValue, choices: choices) { index in
            completion(moves[index])
        }
    }
}
