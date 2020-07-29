//
//  GameUpdateProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 09/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

enum GameUpdate: Equatable {
    case setTurn(String)
    case setChallenge(Challenge?)
    case flipOverFirstDeckCard
    case setupGeneralStore(Int)
    case playerSetBangsPlayed(String, Int)
    case playerSetHealth(String, Int)
    case playerSetDamage(String, DamageEvent)
    case playerPullFromDeck(String)
    case playerPullFromDiscard(String)
    case playerDiscardHand(String, String)
    case playerDiscardTopDeck(String, String)
    case playerPutInPlay(String, String)
    case playerDiscardInPlay(String, String)
    case playerPullFromOtherHand(String, String, String)
    case playerPullFromOtherInPlay(String, String, String)
    case playerPutInPlayOfOther(String, String, String)
    case playerPassInPlayOfOther(String, String, String)
    case playerPullFromGeneralStore(String, String)
    case playerRevealHandCard(String, String)
}
