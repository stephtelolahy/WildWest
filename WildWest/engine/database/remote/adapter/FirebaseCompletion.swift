//
//  FirebaseCompletion.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

enum Result {
    case success
    case error(Error)
}

enum CardResult {
    case success(CardProtocol)
    case error(Error)
}

enum StateResult {
    case success(GameStateProtocol)
    case error(Error)
}

typealias FirebaseCompletion = (Error?) -> Void
typealias FirebaseCardCompletion = (CardProtocol?, Error?) -> Void
typealias FirebaseStateCompletion = (StateResult) -> Void
