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
        player = video.player
        let layer = AVPlayerLayer(player: player)
        layer.frame = contentView.bounds
        layer.videoGravity = .resizeAspectFill
        contentView.layer.addSublayer(layer)
        video.player.play()
    }
    
    override func prepareForReuse() {
        player = nil
        print("reuse cell")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        if let playerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: CMTime.zero, completionHandler: nil)
        }
    }
}
