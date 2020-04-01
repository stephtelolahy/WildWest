//
//  MoveSoundPlayer.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import AVFoundation

protocol MoveSoundPlayerProtocol {
    func playSound(for move: GameMove)
}

class MoveSoundPlayer: MoveSoundPlayerProtocol {
    
    private var sfxPlayers: [AVAudioPlayer] = []
    
    func playSound(for move: GameMove) {
        
        sfxPlayers = sfxPlayers.filter { $0.isPlaying }
        
        let fileName = sfx.value(matching: move)
        guard !fileName.isEmpty else {
            return
        }
        
        guard let path = Bundle.main.path(forResource: "\(fileName).mp3", ofType: nil) else {
            fatalError("File not found \(fileName).mp3")
        }
        
        let url = URL(fileURLWithPath: path)
        do {
            let soundEffect = try AVAudioPlayer(contentsOf: url)
            sfxPlayers.append(soundEffect)
            soundEffect.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    private let sfx: [String: String]  =
        [
            "Bang": "Gun_loud-Soundmaster_-88363983",
            "Beer": "Slurping 2-SoundBible.com-1269549524",
            "CatBalou": "flyby-Conor-1500306612",
            "Choose": "Slide Closed-SoundBible.com-1521580537",
            "Duel": "shotgun-old_school-RA_The_Sun_God-1129942741",
            "EndTurn": "Slide Closed-SoundBible.com-1521580537",
            "Gatling": "Automatic Machine Gun-SoundBible.com-253461580",
            "volcanic": "Shotgun-SoundBible.com-862990674",
            "schofield": "Shotgun-SoundBible.com-862990674",
            "remington": "Shotgun-SoundBible.com-862990674",
            "winchester": "Shotgun-SoundBible.com-862990674",
            "revCarbine": "Shotgun-SoundBible.com-862990674",
            "barrel": "Cowboy_with_spurs-G-rant-1371954508",
            "mustang": "Cowboy_with_spurs-G-rant-1371954508",
            "scope": "Cowboy_with_spurs-G-rant-1371954508",
            "GeneralStore": "Horse Galloping-SoundBible.com-1451398148",
            "Indians": "Peacock-SoundBible.com-1698361099",
            "Jail": "Metal Latch-SoundBible.com-736691159",
            "pass": "342229_christopherderp_hurt-1-male (online-audio-converter.com)",
            "Missed": "Western Ricochet-SoundBible.com-1725886901",
            "Panic": "Slap-SoundMaster13-49669815",
            "Dynamite": "Fuse Burning-SoundBible.com-1372982430",
            "Resolve": "Slide Closed-SoundBible.com-1521580537",
            "Saloon": "Slurping 2-SoundBible.com-1269549524",
            "Stagecoach": "Horse Galloping-SoundBible.com-1451398148",
            "WellsFargo": "Horse Galloping-SoundBible.com-1451398148",
            "Eliminate": "Pain-SoundBible.com-1883168362",
            "Reward": "Horse Galloping-SoundBible.com-1451398148",
            "Penalize": "Slap-SoundMaster13-49669815",
            "stayInJail": "Slide Closed-SoundBible.com-1521580537",
            "escapeFromJail": "Ta Da-SoundBible.com-1884170640",
            "useBarrel": "Western Ricochet-SoundBible.com-1725886901",
            "failBarrel": "Metal Clang-SoundBible.com-19572601",
            "explodeDynamite": "Big Bomb-SoundBible.com-1219802495",
            "passDynamite": "Fuse Burning-SoundBible.com-1372982430",
            "StartTurn": "",
            "startGame": ""
        ]
}
