//
//  LiveStreamingViewController.swift
//  live-stream-APP
//
//  Created by Magic Keegan on 1/9/22.
//

import UIKit
import AgoraRtcKit
import Network


class BroadcasterViewController: UIViewController {
    //监测网络是否正常并进行处理
    let monitor = NWPathMonitor()
    @IBOutlet var networkImage: UIImageView!
    
    var agoraKit: AgoraRtcEngineKit?
    // 定义 localView 变量
    var localView: UIView!
    // 定义 remoteView 变量
    var remoteView: UIView!
    //显示当前时间
    @IBOutlet var timeLable: UILabel!
    
    var timer = Timer()
    
    private func getCurrentTime() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.currentTime) , userInfo: nil, repeats: true)
    }
    
    @objc func currentTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        timeLable.text = formatter.string(from: Date())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //监测网络情况
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                OperationQueue.main.addOperation {
                    self.networkImage.image = nil
                }
            } else {
                OperationQueue.main.addOperation {
                    self.networkImage.image = UIImage(named: "emoji_68")
                }
            }

            print(path.isExpensive)
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        //获取当前时间
        getCurrentTime()
        // 调用初始化视频窗口函数
        initView()
        // 后续步骤调用 Agora API 使用的函数
        initializeAgoraEngine()
        setChannelProfile()
        setClientRole()
        setupLocalVideo()
        joinChannel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        // 后续步骤调用 Agora API 使用的函数
        initializeAgoraEngine()
        setChannelProfile()
        setClientRole()
        setupLocalVideo()
    }
    
    
    // 设置视频窗口布局
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        localView.frame = self.view.bounds
    }
    
    
    
    
    
    func initView() {
        // 初始化远端视频窗口。只有当远端用户为主播时，才会显示视频画面
        //        remoteView = UIView()
        //        self.view.addSubview(remoteView)
        // 初始化本地视频窗口。只有当本地用户为主播时，才会显示视频画面
        localView = UIView()
        self.view.addSubview(localView)
        self.view.sendSubviewToBack(localView)
    }
    
    func initializeAgoraEngine() {
        agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: KeyCenter.AppId, delegate: self)
    }
    func setChannelProfile(){
        agoraKit?.setChannelProfile(.liveBroadcasting)
    }
    
    // ViewController.swift
    func setClientRole(){
        // 设置用户角色为主播
        agoraKit?.setClientRole(.broadcaster)
        // 设置用户角色为观众
        //    agoraKit?.setClientRole(.audience)
    }
    
    func setupLocalVideo() {
        // 启用视频模块
        agoraKit?.enableVideo()
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = 0
        videoCanvas.renderMode = .hidden
        videoCanvas.view = localView
        // 设置本地视图
        agoraKit?.setupLocalVideo(videoCanvas)
    }
    
    func joinChannel(){
        // 频道内每个用户的 uid 必须是唯一的
        agoraKit?.joinChannel(byToken: KeyCenter.TokenPUBLISHER, channelId: "MVPApp", info: nil, uid: 1, joinSuccess: { (channel, uid, elapsed) in
        })
    }
    
    
    
    func leaveChannel() {
        agoraKit?.leaveChannel(nil)
    }
    
    
    
    // ViewController.swift，需要在 class ViewController: UIViewController 函数之外添加以下代码
    
}

extension BroadcasterViewController: AgoraRtcEngineDelegate {
    // 监听 didJoinedOfUid 回调
    // 远端主播加入频道时，会触发该回调
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.renderMode = .hidden
        videoCanvas.view = remoteView
        // 设置远端视图
        agoraKit?.setupRemoteVideo(videoCanvas)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
