//
//  VideoCell.swift
//  live-stream-APP
//
//  Created by Magic Keegan on 12/13/21.
//

import UIKit
import AVKit

class VideoCell: UICollectionViewCell {
    //    static let identifer = "videoCell"
    var player: AVPlayer!
    var isLiked: Bool!
    
    @IBAction func like(_ sender: UIButton) {
        isLiked = !isLiked
        
        if isLiked{
            sender.setImage(UIImage(systemName:"heart.fill")?.withTintColor(.red,
                                                                             renderingMode: .alwaysOriginal), for: .normal)
            likeAnimation(button: sender)
        }
        else{
            sender.setImage(UIImage(systemName:"heart.fill")?.withTintColor(.white,
                                                                             renderingMode: .alwaysOriginal), for: .normal)
        }
    }
    @IBOutlet var likeButton: UIButton!
    public func configure(with video:Video){
        player = video.player
        isLiked = video.isLiked
        let layer = AVPlayerLayer(player: player)
        layer.frame = contentView.bounds
        layer.videoGravity = .resizeAspectFill
        //将视频播放控件置于底部
        layer.zPosition = -1
        contentView.layer.addSublayer(layer)
        video.player.play()
    }
    
    override func prepareForReuse() {
        player = nil
        print("reuse cell")
    }
    
    //MARK 点赞动画实现
    private func likeAnimation(button:UIButton){
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping:0.5, initialSpringVelocity: 0.5,options: [.allowUserInteraction],
                       animations: {
            self.emitterLayer.birthRate = 5
            button.layer.addSublayer(self.emitterLayer)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                self.emitterLayer.birthRate = 0
            }
            button.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
            button.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion:nil)
        
    }
    let emitterLayer:CAEmitterLayer! = {
        let emitterLayer = CAEmitterLayer()
        
        emitterLayer.emitterPosition = CGPoint(x: 0, y: 0)
        
        let cell = CAEmitterCell()
        cell.alphaSpeed = -1.0
        cell.alphaRange = 0.5
        cell.birthRate = 1
        cell.lifetime = 1
        cell.velocity = 40
        cell.scale = 0.5
        cell.emissionLongitude = -.pi / 2
        cell.emissionRange = .pi
        cell.contents = UIImage(named: "emoji_52")?.withTintColor(.white,
                                                                        renderingMode: .alwaysOriginal).cgImage
        emitterLayer.emitterCells = [cell]
        return emitterLayer
    }()
    
}

