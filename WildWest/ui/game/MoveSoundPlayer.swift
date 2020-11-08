//
//  MoveSoundPlayer.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import AVFoundation
import CardGameEngine

protocol MoveSoundPlayerProtocol {
    func playSound(for move: GMove)
}

class MoveSoundPlayer: MoveSoundPlayerProtocol {
    
    private var sfxPlayers: [AVAudioPlayer] = []
    
    func playSound(for move: GMove) {
        /*
        sfxPlayers = sfxPlayers.filter { $0.isPlaying }
        
        guard let fileName = sfxFile(for: move),
            let path = Bundle.main.path(forResource: "\(fileName).mp3", ofType: nil) else {
                fatalError("Illegal state")
        }
        
        let url = URL(fileURLWithPath: path)
        do {
            let soundEffect = try AVAudioPlayer(contentsOf: url)
            sfxPlayers.append(soundEffect)
            soundEffect.play()
        } catch {
            // couldn't load file :(
        }
        */
    }
    /*
    private func sfxFile(for move: GameMove) -> String? {
        if move.name == .equip,
            let cardName = move.cardId?.extractCardName() {
            return equipSfx[cardName]
        }
        
        return sfx[move.name]
    }
    
    private let sfx: [MoveName: String] = [
        .beer: "Slurping 2-SoundBible.com-1269549524",
        .saloon: "Slurping 2-SoundBible.com-1269549524",
        .stagecoach: "Horse Galloping-SoundBible.com-1451398148",
        .wellsFargo: "Horse Galloping-SoundBible.com-1451398148",
        .panic: "Slap-SoundMaster13-49669815",
        .catBalou: "flyby-Conor-1500306612",
        .dynamite: "Fuse Burning-SoundBible.com-1372982430",
        .jail: "Metal Latch-SoundBible.com-736691159",
        .generalStore: "Horse Galloping-SoundBible.com-1451398148",
        .bang: "Gun_loud-Soundmaster_-88363983",
        .gatling: "Automatic Machine Gun-SoundBible.com-253461580",
        .indians: "Peacock-SoundBible.com-1698361099",
        .duel: "shotgun-old_school-RA_The_Sun_God-1129942741",
        .discardMissed: "Western Ricochet-SoundBible.com-1725886901",
        .discardBang: "Gun_loud-Soundmaster_-88363983",
        .discardBeer: "Slurping 2-SoundBible.com-1269549524",
        .pass: "342229_christopherderp_hurt-1-male (online-audio-converter.com)",
        .choose: "Slide Closed-SoundBible.com-1521580537",
        .endTurn: "Slide Closed-SoundBible.com-1521580537",
        .startTurn: "Slide Closed-SoundBible.com-1521580537",
        .startTurnDrawAnotherCardIfRedSuit: "Slide Closed-SoundBible.com-1521580537",
        .startTurnDraw3CardsAndKeep2: "Slide Closed-SoundBible.com-1521580537",
        .startTurnDrawFirstCardFromOtherPlayer: "Slide Closed-SoundBible.com-1521580537",
        .startTurnDrawFirstCardFromDiscard: "Slide Closed-SoundBible.com-1521580537",
        .passDynamite: "Fuse Burning-SoundBible.com-1372982430",
        .dynamiteExploded: "Big Bomb-SoundBible.com-1219802495",
        .stayInJail: "Slide Closed-SoundBible.com-1521580537",
        .escapeFromJail: "Ta Da-SoundBible.com-1884170640",
        .useBarrel: "Western Ricochet-SoundBible.com-1725886901",
        .failBarrel: "Metal Clang-SoundBible.com-19572601",
        .eliminate: "Pain-SoundBible.com-1883168362",
        .gainRewardOnEliminatingOutlaw: "Horse Galloping-SoundBible.com-1451398148",
        .penalizeSheriffOnEliminatingDeputy: "Slap-SoundMaster13-49669815",
        .drawsCardOnLoseHealth: "Slide Closed-SoundBible.com-1521580537",
        .drawsCardFromPlayerDamagedHim: "Slap-SoundMaster13-49669815",
        .drawsCardWhenHandIsEmpty: "Slide Closed-SoundBible.com-1521580537",
        .discard2CardsFor1Life: "Slurping 2-SoundBible.com-1269549524"
    ]
    
    private var equipSfx: [CardName: String] = [
        .volcanic: "Shotgun-SoundBible.com-862990674",
        .schofield: "Shotgun-SoundBible.com-862990674",
        .remington: "Shotgun-SoundBible.com-862990674",
        .winchester: "Shotgun-SoundBible.com-862990674",
        .revCarbine: "Shotgun-SoundBible.com-862990674",
        .barrel: "Cowboy_with_spurs-G-rant-1371954508",
        .mustang: "Cowboy_with_spurs-G-rant-1371954508",
        .scope: "Cowboy_with_spurs-G-rant-1371954508"
    ]
 */
}
