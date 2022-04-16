//
//  AudioPlayer.swift
//  restart(swiftUI)
//
//  Created by Yerkebulan Serikov on 15.04.2022.
//

import Foundation
import AVFoundation

var audioPlayer : AVAudioPlayer?

func playSound(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type)
    {
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }catch{
            print("Cound not play the sound file")
        }
    }
}

