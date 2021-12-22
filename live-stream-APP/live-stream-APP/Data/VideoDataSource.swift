//
//  Video.swift
//  live-stream-APP
//
//  Created by Magic Keegan on 12/5/21.
//
import AVFoundation
class Video{
    var id : Int
    var player : AVPlayer
    var isLiked:  Bool
    var comments = [Comment(words: "评论区:")]
    init(id : Int,player : AVPlayer,isLiked:Bool){
            self.id = id
            self.player = player
            self.isLiked = isLiked
    }
}

class VideoDataSource {
    static let sharedInstance = VideoDataSource()
    
    var videos = [
        Video(id: 0, player: AVPlayer(url:URL(fileURLWithPath: Bundle.main.path(forResource: "demo1", ofType: "MP4")!)),isLiked: false),
        Video(id: 1, player: AVPlayer(url:URL(fileURLWithPath: Bundle.main.path(forResource: "demo1", ofType: "MP4")!)),isLiked: false),
        Video(id: 2, player: AVPlayer(url:URL(fileURLWithPath: Bundle.main.path(forResource: "demo1", ofType: "MP4")!)),isLiked: false),
        Video(id: 3, player: AVPlayer(url:URL(fileURLWithPath: Bundle.main.path(forResource: "demo1", ofType: "MP4")!)),isLiked: false),
        Video(id: 4, player: AVPlayer(url:URL(fileURLWithPath: Bundle.main.path(forResource: "demo1", ofType: "MP4")!)),isLiked: false),
        Video(id: 5, player: AVPlayer(url:URL(fileURLWithPath: Bundle.main.path(forResource: "demo1", ofType: "MP4")!)),isLiked: false),
    ]
}
