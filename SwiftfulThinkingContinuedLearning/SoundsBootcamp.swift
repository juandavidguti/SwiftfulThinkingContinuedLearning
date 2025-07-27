//
//  Untitled.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Juan David Gutierrez Olarte on 26/07/25.
//

import SwiftUI
import AVKit

class SoundManager {
    static let instance = SoundManager() // singleton
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case tada /*= "tada_sound" could work as well to change the name*/
        case badum
    }
    
    func playSound(sound: SoundOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
        
    }
    
}

struct SoundsBootcamp: View {
    
    var body: some View {
        VStack(spacing: 40) {
            Button ("Play Sound 1") {
                SoundManager.instance.playSound(sound: .tada)
            }
            Button ("Play Sound 2") {
                SoundManager.instance.playSound(sound: .badum)
            }
        }
    }
}

#Preview {
    SoundsBootcamp()
}
