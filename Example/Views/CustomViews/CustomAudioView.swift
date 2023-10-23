//
//  CustomAudioView.swift
//  Example
//
//  Created by MAHESHWARAN on 23/10/23.
//

import SwiftUI
import AVKit

private class SoundManager {
  
  static let shared = SoundManager()
  
  var player: AVAudioPlayer?
  
  func playSound() {
    guard let url = Bundle.main.url(
      forResource: "Ding", withExtension: ".mp3") else { return }
    
    do {
      player = try AVAudioPlayer(contentsOf: url)
      player?.play()
    } catch {
      print("Error while creating audio player")
    }
  }
}

struct CustomAudioView: View {
  
  var body: some View {
    Button("Play Audio") {
      SoundManager.shared.playSound()
    }
    .buttonStyle(.borderedProminent)
    .tint(.pink)
  }
  
}

#Preview {
  CustomAudioView()
}
