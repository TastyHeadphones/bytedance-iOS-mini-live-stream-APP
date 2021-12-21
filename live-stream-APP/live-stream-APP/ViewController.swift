//
//  ViewController.swift
//  live-stream-APP
//
//  Created by Magic Keegan on 12/5/21.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    
    @IBOutlet var videoView: VideoView!
    
    
    override func viewDidLoad() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        //切换视频时消除间隙 使每个视频都能够覆盖屏幕
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        videoView.frame = .zero
        videoView.collectionViewLayout = layout

        videoView?.isPagingEnabled = true
        videoView?.dataSource = self
        videoView?.backgroundColor = .black
        //消除顶端和底部的间隙
        videoView?.contentInsetAdjustmentBehavior = .never
        
    }
    
    override func viewDidLayoutSubviews() {
        videoView?.frame = UIScreen.main.bounds
    }
    
}
extension ViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return VideoDataSource.sharedInstance.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! VideoCell
        
//        var video = VideoDataSource.sharedInstance.videos[indexPath.row]
        cell.configure(with: VideoDataSource.sharedInstance.videos[indexPath.row])
        cell.commentView.dataSource = cell.self
        return cell
    }
}


