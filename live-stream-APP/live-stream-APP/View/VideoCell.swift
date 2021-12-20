//
//  VideoCell.swift
//  live-stream-APP
//
//  Created by Magic Keegan on 12/13/21.
//

import UIKit
import AVKit
class VideoCell: UICollectionViewCell {
    static let identifer = "videoCell"
    var player: AVPlayer?
    
    public func configure(with video:Video){
        player = AVPlayer(url:URL(fileURLWithPath: Bundle.main.path(forResource: "demo1", ofType: "MP4")!))
        
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resizeAspectFill
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.addSubview(playerViewController.view)
    }
}
