//
//  ResolveBarrelTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

/**
 Barrel
 The Barrel allows you to “draw!” when you are the target of a BANG!:
 - if you draw a Heart card, you are Missed! (just like if you
 played a Missed! card);
 - otherwise nothing happens.
 Example. You are the target of another player’s BANG! You
 have a Barrel in play: this card lets you “draw!” to cancel a
 BANG! and it is successful on a Heart. So, you flip the top card
 of the deck and put it on the discard pile:
 it’s a 4 of Hearts. The use of the Barrel
 is successful and cancels the BANG!
 If the flipped card were of a different
 suit, then the Barrel would have had no
 effect, but you could have still tried to cancel the BANG!
 with a Missed!.
 */
class ResolveBarrelTests: XCTestCase {

}

class ResolveBarrelRuleTests: XCTestCase {

}
