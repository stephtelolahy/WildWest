//
//  SFXEventMatcher.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import CardGameEngine

protocol SFXEventMatcherProtocol {
    func sfx(on event: GEvent) -> String?
}

class SFXEventMatcher: SFXEventMatcherProtocol {
    
    func sfx(on event: GEvent) -> String? {
        Self.sfx[event.hashValue]
    }
}

private extension SFXEventMatcher {
    
    static let sfx: [String: String] = [
        "drawDeck": "Slide Closed-SoundBible.com-1521580537",
        "drawDiscard": "Slide Closed-SoundBible.com-1521580537",
        "putInPlay": "Shotgun-SoundBible.com-862990674",
        "revealHand": "Slide Closed-SoundBible.com-1521580537",
        "discardInPlay": "flyby-Conor-1500306612",
        "drawHand": "Slap-SoundMaster13-49669815",
        "drawInPlay": "Slap-SoundMaster13-49669815",
        "putInPlayOther": "Metal Latch-SoundBible.com-736691159",
        "passInPlayOther": "Fuse Burning-SoundBible.com-1372982430",
        "revealDeck": "Slide Closed-SoundBible.com-1521580537",
        "deckToStore": "Slide Closed-SoundBible.com-1521580537",
        "storeToDeck": "Slide Closed-SoundBible.com-1521580537",
        "drawStore": "Slide Closed-SoundBible.com-1521580537",
        "gainHealth": "Slurping 2-SoundBible.com-1269549524",
        "looseHealth": "342229_christopherderp_hurt-1-male (online-audio-converter.com)",
        "eliminate": "Pain-SoundBible.com-1883168362",
        "addHit": "Gun_loud-Soundmaster_-88363983"
    ]
}

/*

private let sfx: [MoveName: String] = [
    .stagecoach: "Horse Galloping-SoundBible.com-1451398148",
    .wellsFargo: "Horse Galloping-SoundBible.com-1451398148",
    .generalStore: "Horse Galloping-SoundBible.com-1451398148",
    .bang: "Gun_loud-Soundmaster_-88363983",
    .gatling: "Automatic Machine Gun-SoundBible.com-253461580",
    .indians: "Peacock-SoundBible.com-1698361099",
    .duel: "shotgun-old_school-RA_The_Sun_God-1129942741",
    .discardBang: "Gun_loud-Soundmaster_-88363983",
    .dynamiteExploded: "Big Bomb-SoundBible.com-1219802495",
    .escapeFromJail: "Ta Da-SoundBible.com-1884170640",
    .failBarrel: "Metal Clang-SoundBible.com-19572601",
 "missed": "Western Ricochet-SoundBible.com-1725886901",
]

private var equipSfx: [CardName: String] = [
    .barrel: "Cowboy_with_spurs-G-rant-1371954508",
    .mustang: "Cowboy_with_spurs-G-rant-1371954508",
    .scope: "Cowboy_with_spurs-G-rant-1371954508"
]
*/
