//
//  ViewController.swift
//  live-stream-APP
//
//  Created by Magic Keegan on 12/5/21.
//

import UIKit
import AVKit

class ViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet var videoView: VideoView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        videoView.frame = view.bounds
        videoView.delegate = self
        videoView.showsVerticalScrollIndicator = false
        videoView.showsHorizontalScrollIndicator = false
        videoView.backgroundColor = .black
        
        var yPos = 0
        VideoDataSource.sharedInstance.videos.forEach { (video) in
            let playerViewController =  makePlayerViewController(player: video.player, yPos:CGFloat(yPos))
            let titleLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 50));
            titleLabel.text = "字节项目第\(video.id)个视频"
            titleLabel.textColor = .red
            playerViewController.contentOverlayView?.addSubview(titleLabel)
            videoView.addSubview(playerViewController.view)
            self.addChild(playerViewController)
            yPos = yPos + Int(UIScreen.main.bounds.height)
        }
        
        VideoDataSource.sharedInstance.currentIndex = 0
        
        videoView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((VideoDataSource.sharedInstance.videos.count)))
        
        videoView.showsVerticalScrollIndicator = false
        videoView.showsHorizontalScrollIndicator = false
        
        videoView.contentInsetAdjustmentBehavior = .never
        videoView.isPagingEnabled = true
        
        print("scrollView Added")
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
////        print("good")
//        if (videoView.contentOffset.y >= view.frame.height) {  // 上滑
////            videoView.player.pause()
//            videoView.contentOffset = CGPoint(x: 0, y: view.frame.height)
//            print("up")
//        }
//        else if(videoView.contentOffset.y < 0){
//            videoView.contentOffset = CGPoint(x: 0, y: view.frame.height)
//            print("down")
//        }
//    }
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//        let translatedPoint = scrollView.panGestureRecognizer.translation(in: scrollView)
//
//        if (translatedPoint.y >= 50) {  // 上滑
////            videoView.player.pause()
//            videoView.contentOffset = CGPoint(x: 0, y: view.frame.height)
//            print("up")
//        }
//        else if(translatedPoint.y <= -50){
//            videoView.contentOffset = CGPoint(x: 0, y: view.frame.height)
//            print("down")
//        }
//    }
    func makePlayerViewController(player: AVPlayer, yPos: CGFloat) -> AVPlayerViewController{
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.showsPlaybackControls = false
        playerViewController.videoGravity = .resizeAspect
        playerViewController.view.backgroundColor = .black
        playerViewController.view.frame = CGRect(x: 0, y: yPos, width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return playerViewController
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.y / UIScreen.main.bounds.height)
        
        if VideoDataSource.sharedInstance.currentIndex != index {
            VideoDataSource.sharedInstance.currentIndex = index
        }
    }
    
}

