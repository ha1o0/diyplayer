//
//  DiyPlayerView.swift
//  diyplayer
//
//  Created by sidney on 2018/8/26.
//  Copyright © 2018年 sidney. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import SnapKit
import MediaPlayer

class DiyPlayerView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var fullBtn: UIButton!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var timeDisplay: UILabel!
    @IBOutlet weak var cacheSlider: UISlider!
    
    var playerItem: AVPlayerItem!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var isPlay = false
    var systemVolumeView = MPVolumeView()
//    var videoUrl = "http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8"
    var videoUrl = "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
//    var videoUrl = "http://221.228.226.5/15/t/s/h/v/tshvhsxwkbjlipfohhamjkraxuknsc/sh.yinyuetai.com/88DC015DB03C829C2126EEBBB5A887CB.mp4"
    var totalTimeSeconds = 0
    var totalTime = "00:00"
    var currentTime = "00:00"
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("frame")
        Bundle.main.loadNibNamed("DiyPlayerView", owner: self, options: nil)
        self.frame = frame
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("coder")
    }

    func addGesture() {
        // 双击播放和暂停手势
        let doubleTap = UITapGestureRecognizer(target: self, action:#selector(doubleTapPlayer))
        doubleTap.numberOfTapsRequired = 2
        self.playerView.addGestureRecognizer(doubleTap)
        // 滑动+-音量手势
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUpVolume))
        swipeUp.direction = .up
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownVolume))
        swipeDown.direction = .down
        self.playerView.addGestureRecognizer(swipeUp)
        self.playerView.addGestureRecognizer(swipeDown)
    }

    func initMPVolumeView() {
        systemVolumeView.frame.size = CGSize.init(width: 200, height: 1)
        systemVolumeView.center = self.playerView.center
        systemVolumeView.isHidden = true
        self.playerView.addSubview(systemVolumeView)
    }

    private func getSystemVolumeSlider() -> UISlider {
        var volumeViewSlider = UISlider()
        for subView in systemVolumeView.subviews {
            if type(of: subView).description() == "MPVolumeSlider" {
                volumeViewSlider = subView as! UISlider
                return volumeViewSlider
            }
        }
        return volumeViewSlider
    }

    private func getSystemVolumeValue() -> Float {
        return self.getSystemVolumeSlider().value
    }

    private func setSystemVolumeValue(_ value: Float) {
        self.getSystemVolumeSlider().value = value
    }

    func commonInit() {
        initSlider()
        addGesture()
        initMPVolumeView()
        print("commoninit")
        guard let url = URL(string: videoUrl) else {
            print(videoUrl)
            fatalError("连接错误")
        }
        let asset = AVAsset(url: url)
        playerItem = AVPlayerItem(asset: asset)
        playerItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: NSKeyValueObservingOptions.new, context: nil)
        playerItem.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil)
        player = AVPlayer(playerItem: playerItem)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        playerLayer.contentsScale = UIScreen.main.scale
        playerLayer.frame = self.bounds
        self.playerView.layer.insertSublayer(playerLayer, at: 0)
        contentView.frame = self.bounds
        addSubview(contentView)
    }
    
    func initSlider() {
        progressSlider.setThumbImage(UIImage(named: "sliderThumb"), for: .normal)
        progressSlider.setThumbImage(UIImage(named: "sliderThumb"), for: .highlighted)
        progressSlider.minimumValue = 0
        progressSlider.value = 0
        cacheSlider.isUserInteractionEnabled = false
        cacheSlider.setThumbImage(UIImage(named: "transparent"), for: .normal)
        cacheSlider.setThumbImage(UIImage(named: "transparent"), for: .highlighted)
        cacheSlider.minimumValue = 0
        cacheSlider.value = 0
    }
    
    override func layoutSubviews() {
        print("layout")
        super.layoutSubviews()
    }

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        // Only handle observations for the playerItemContext
//        guard context == &playerItemContext else {
//            super.observeValue(forKeyPath: keyPath,
//                               of: object,
//                               change: change,
//                               context: context)
//            return
//        }
        
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItemStatus
            
            // Get the status change from the change dictionary
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItemStatus(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }
            
            // Switch over the status
            switch status {
            case .readyToPlay:
                totalTimeSeconds = Int(playerItem.duration.value) / Int(playerItem.duration.timescale)
                progressSlider.maximumValue = Float(totalTimeSeconds)
                cacheSlider.maximumValue = Float(totalTimeSeconds)
                totalTime = "\(TimeUtil.getTimeMinutesBySeconds(totalTimeSeconds)):\(TimeUtil.getTimeSecondBySeconds(totalTimeSeconds))"
                timeDisplay.text = "00:00/\(totalTime)"
                NotificationCenter.default.addObserver(self, selector: #selector(playToEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player.currentItem)
                player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1/30.0, Int32(NSEC_PER_SEC)), queue: nil, using: { (time) in
                    self.timeDisplay.text = "\(TimeUtil.getTimeMinutesBySeconds(Int(CMTimeGetSeconds(time)))):\(TimeUtil.getTimeSecondBySeconds(Int(CMTimeGetSeconds(time))))/\(self.totalTime)"
                    self.progressSlider.value = Float(CMTimeGetSeconds(time))
                })
                
                break
            // Player item is ready to play.
            case .failed:
                print("1111111")
                break
            // Player item failed. See error.
            case .unknown:
                print("2222222")
                break
                // Player item is not yet ready.
            }
        }
        
        if keyPath == #keyPath(AVPlayerItem.loadedTimeRanges) {
            let cacheSeconds = Int(playerItem.loadedTimeRanges[0].timeRangeValue.duration.value) / Int(playerItem.loadedTimeRanges[0].timeRangeValue.duration.timescale)
            if totalTimeSeconds > 0 && Float(cacheSeconds) > cacheSlider.value {
                cacheSlider.value = Float(cacheSeconds)
            }
        }
    }
    
    @IBAction func playOrPause(_ sender: UIButton) {
        isPlay ? player.pause() : player.play()
        isPlay = !isPlay
        sender.setImage(isPlay ? UIImage(named: "pause") : UIImage(named: "play"), for: .normal)
    }

    @objc func doubleTapPlayer() {
        print("double tap")
        playOrPause(self.playBtn)
    }

    @objc func swipeUpVolume() {
        print("swipe up", self.getSystemVolumeValue())
        self.setSystemVolumeValue(self.getSystemVolumeValue() + 0.1)
        print("swipe up", self.getSystemVolumeValue())
    }

    @objc func swipeDownVolume() {
        print("swipe down", self.getSystemVolumeValue())
        self.setSystemVolumeValue(self.getSystemVolumeValue() - 0.1)
        print("swipe down", self.getSystemVolumeValue())
    }

    @objc func playToEnd() {
        isPlay = false
        playBtn.setImage(UIImage(named: "play"), for: .normal)
        playerItem.seek(to: kCMTimeZero) { (bool) in }
    }
    
    deinit {
        playerItem.removeObserver(self, forKeyPath: "loadedTimeRanges")
        playerItem.removeObserver(self, forKeyPath: "status")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
}
