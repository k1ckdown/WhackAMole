//
//  AudioPlayer.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 01.06.2023.
//

import Foundation
import AVFoundation

final class AudioPlayer {

    private var player: AVAudioPlayer?
    private let mediaUrl: URL

    init(mediaUrl: URL) {
        self.mediaUrl = mediaUrl
    }

    func play() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: mediaUrl, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

}
