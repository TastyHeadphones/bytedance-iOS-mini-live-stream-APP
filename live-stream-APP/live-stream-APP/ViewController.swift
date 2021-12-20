//
//  ViewController.swift
//  live-stream-APP
//
//  Created by Magic Keegan on 12/5/21.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    private var videoView: UICollectionView?
    
    override func viewDidLoad() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        videoView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        videoView?.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.identifer)
        videoView?.isPagingEnabled = true
        videoView?.dataSource = self
        videoView?.backgroundColor = .red
        view.addSubview(videoView!)
    }
    
    override func viewDidLayoutSubviews() {
        videoView?.frame = view.bounds
    }
    
}
extension ViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = videoView?.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! VideoCell
        cell.bounds = UIScreen.main.bounds
//        cell.configure(with: )
        
        return cell
    }
    
    
    
}
