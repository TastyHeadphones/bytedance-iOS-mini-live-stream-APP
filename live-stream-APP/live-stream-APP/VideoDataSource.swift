//
//  Video.swift
//  live-stream-APP
//
//  Created by Magic Keegan on 12/5/21.
//
import AVFoundation
struct Video : Identifiable {
    var id : Int
    var player : AVPlayer
}

class VideoDataSource {
    static let sharedInstance = VideoDataSource()
    
    var videos = [
        Video(id: 0, player: AVPlayer(url:URL(fileURLWithPath: Bundle.main.path(forResource: "demo1", ofType: "MP4")!))),
        Video(id: 1, player: AVPlayer(url:URL(fileURLWithPath: Bundle.main.path(forResource: "demo1", ofType: "MP4")!))),
        Video(id: 2, player: AVPlayer(url:URL(fileURLWithPath: Bundle.main.path(forResource: "demo1", ofType: "MP4")!))),
        Video(id: 3, player: AVPlayer(url:URL(fileURLWithPath: Bundle.main.path(forResource: "demo1", ofType: "MP4")!))),
        Video(id: 4, player: AVPlayer(url:URL(fileURLWithPath: Bundle.main.path(forResource: "demo1", ofType: "MP4")!))),
        Video(id: 5, player: AVPlayer(url:URL(fileURLWithPath: Bundle.main.path(forResource: "demo1", ofType: "MP4")!))),
    ]
}
