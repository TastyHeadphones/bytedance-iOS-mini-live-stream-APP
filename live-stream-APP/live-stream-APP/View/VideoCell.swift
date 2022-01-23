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
    @IBOutlet var commentView: UITableView!
    @IBOutlet var textField: UITextField!
    
    var video: Video!
    //视频循环播放
    @objc func playerItemDidReachEnd(notification: Notification) {
        if let playerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: CMTime.zero, completionHandler: nil)
        }
    }
    

    
    var isLiked:Bool!{
        didSet{
            if isLiked{
                likeButton.setImage(UIImage(systemName:"heart.fill")?.withTintColor(.red,
                                                                                    renderingMode: .alwaysOriginal), for: .normal)
            }
            else{
                likeButton.setImage(UIImage(systemName:"heart.fill")?.withTintColor(.white,
                                                                                    renderingMode: .alwaysOriginal), for: .normal)
            }
        }
    }
    
    @IBAction func like(_ sender: Any) {
        likeChange()
    }
    
    @IBAction func gift(_ sender: UIButton){
        buttonAnimation(button: sender)
    }
        
    //双击点赞动画
    @objc func doubleClickHandle(recognizer:UITapGestureRecognizer){
        likeChange()
        let point = recognizer.location(in: self.contentView)
//        print(point)
        var image = UIImage(named: "emoji_24")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        imageView.image = image
        imageView.center = point
        
        let leftOrRight = arc4random() % 2
        imageView.transform = imageView.transform.rotated(by: .pi / 9.0 * Double(leftOrRight))
        
        contentView.addSubview(imageView)
        
        UIView.animate(withDuration: 2) {
            imageView.transform.scaledBy(x: 1.2, y: 1.2)
            imageView.transform.scaledBy(x: 1.0, y: 1.0)
            imageView.frame.origin.y = -100
            imageView.alpha = 0.0
        } completion: { finished in
            imageView.removeFromSuperview()
            image = nil
        }
    }
    
    @objc func dismissKeyboard(){
        textField.resignFirstResponder()
    }
    

    
    private func likeChange(){
        video.isLiked = !video.isLiked
        isLiked = !isLiked
        if(isLiked){
            buttonAnimation(button: likeButton)
        }
    }
    
    
    @IBOutlet var likeButton: UIButton!
    public func configure(with video: Video){
        
        self.video = video
        self.isLiked = video.isLiked
        let layer = AVPlayerLayer(player: self.video.player)
        layer.frame = contentView.bounds
        layer.videoGravity = .resizeAspectFill
        //将视频播放控件置于底部
        layer.zPosition = -1
        contentView.layer.addSublayer(layer)
        //增加点赞控件
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleClickHandle))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        singleTap.numberOfTapsRequired = 1
        addGestureRecognizer(singleTap)
        textField.delegate = self
        //视频循环播放
        self.video.player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: self.video.player.currentItem)
        
        self.video.player.play()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.commentView.dataSource = nil
    }
    
    
    //MARK 点赞动画实现
    private func buttonAnimation(button:UIButton){
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping:0.5, initialSpringVelocity: 0.5,options: [.allowUserInteraction],
                       animations: {
//            self.emitterLayer.birthRate = 5
//            button.layer.addSublayer(self.emitterLayer)
//            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
//                self.emitterLayer.birthRate = 0
//            }
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

extension VideoCell:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return video.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        cell.textLabel?.text = video.comments[indexPath.row].words
        cell.textLabel?.textColor = .white
        return cell
    }
}

//添加公屏评论
extension VideoCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text,!textField.text!.isEmpty{
            print(text)
            textField.text = ""
            video.comments.append(Comment(words: text))
            OperationQueue.main.addOperation {
                self.commentView.reloadData()
            }
        }
        return false
    }
}
