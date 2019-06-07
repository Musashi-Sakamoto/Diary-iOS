//
//  AVPlayerView.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/07.
//  Copyright © 2019 musashi. All rights reserved.
//

import AVFoundation
import UIKit

class VideoContainerView: UIView {
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

    override var layer: AVPlayerLayer {
        return super.layer as! AVPlayerLayer
    }

    func set(player: AVPlayer) {
        self.layer.player = player
    }

    func play() {
        self.layer.player?.play()
    }
}
