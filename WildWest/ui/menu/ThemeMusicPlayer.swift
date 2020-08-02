//
//  ThemeMusicPlayer.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 26/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import AVFoundation

class ThemeMusicPlayer {
    
    private var audioPlayer: AVAudioPlayer?
    
    func play() {
        let musicFile = "2017-03-24_-_Lone_Rider_-_David_Fesliyan.mp3"
        guard let path = Bundle.main.path(forResource: musicFile, ofType: nil) else {
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            fatalError("couldn't load file")
        }
    }
    
    func stop() {
        audioPlayer?.stop()
    }
    
}
