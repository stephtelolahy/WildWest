//
//  SoundPlayer.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import AVFoundation
import Resolver

protocol SoundPlayerProtocol {
    func play(_ fileName: String)
    func stop()
}

class SoundPlayer: SoundPlayerProtocol {
    
    private lazy var preferences: UserPreferencesProtocol = Resolver.resolve()
    
    private var audioPlayers: [AVAudioPlayer] = []
    
    func play(_ fileName: String) {
        guard preferences.enableSound else {
            return
        }
        
        audioPlayers.removeAll(where: { !$0.isPlaying })
        
        do {
            let path = try Bundle.main.path(forResource: "\(fileName).mp3", ofType: nil).unwrap()
            let url = URL(fileURLWithPath: path)
            let soundEffect = try AVAudioPlayer(contentsOf: url)
            audioPlayers.append(soundEffect)
            soundEffect.play()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func stop() {
        audioPlayers.forEach { $0.stop() }
    }
}
