//
//  SFXPlayer.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import AVFoundation
import Resolver

protocol SFXPlayerProtocol {
    func play(_ fileName: String)
    func stop()
}

class SFXPlayer: SFXPlayerProtocol {
    
    private lazy var preferences: UserPreferencesProtocol = Resolver.resolve()
    
    private var sfxPlayers: [AVAudioPlayer] = []
    
    func play(_ fileName: String) {
        guard preferences.enableSound else {
            return
        }
        
        sfxPlayers.removeAll(where: { !$0.isPlaying })
        
        do {
            let path = try Bundle.main.path(forResource: "\(fileName).mp3", ofType: nil).unwrap()
            let url = URL(fileURLWithPath: path)
            let soundEffect = try AVAudioPlayer(contentsOf: url)
            sfxPlayers.append(soundEffect)
            soundEffect.play()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func stop() {
        sfxPlayers.forEach { $0.stop() }
    }
}
