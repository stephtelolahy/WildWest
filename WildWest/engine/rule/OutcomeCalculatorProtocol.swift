//
//  OutcomeCalculatorProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 14/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol OutcomeCalculatorProtocol {
    func outcome(for remainingRoles: [Role]) -> GameOutcome?
}
