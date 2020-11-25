//
//  SFXPlayer.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import AVFoundation

protocol SFXPlayerProtocol {
    func playSound(named fileName: String)
}

class SFXPlayer: SFXPlayerProtocol {
    
    private var sfxPlayers: [AVAudioPlayer] = []
    
    func playSound(named fileName: String) {
        sfxPlayers = sfxPlayers.filter { $0.isPlaying }
        
        guard let path = Bundle.main.path(forResource: "\(fileName).mp3", ofType: nil) else {
            fatalError("Illegal state")
        }
        
        let url = URL(fileURLWithPath: path)
        do {
            let soundEffect = try AVAudioPlayer(contentsOf: url)
            sfxPlayers.append(soundEffect)
            soundEffect.play()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
