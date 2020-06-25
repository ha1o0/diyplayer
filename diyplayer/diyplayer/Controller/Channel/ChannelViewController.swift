//
//  ChannelViewController.swift
//  diyplayer
//
//  Created by sidney on 2019/7/21.
//  Copyright © 2019 sidney. All rights reserved.
//

import UIKit
import MediaPlayer
import SDWebImage
import FreeStreamer

class ChannelViewController: CustomViewController {

    @IBOutlet weak var imageView: UIImageView!
    var musicUrl = "http://www.0dutv.com/plug/down/up2.php/105030812.mp3"
    var audioStream: FSAudioStream?
    var isInit: Bool = true
    var current: UInt32 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioStream = FSAudioStream.init(url: URL(string: musicUrl))
        audioStream?.onStateChange = { event in
            print(event)
        }
        setupRemoteTransportControls()
        setupNowPlaying()
        // Do any additional setup after loading the view.
    }


    func setupRemoteTransportControls() {
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()

        // Add handler for Play Command
        commandCenter.playCommand.addTarget { [unowned self] event in
            if !(self.audioStream?.isPlaying())! {
                self.play(UIButton())
                self.updateNowPlaying()
                return .success
            }
            return .commandFailed
        }

        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            if (self.audioStream?.isPlaying())! {
                self.pause(UIButton())
                self.updateNowPlaying()
                return .success
            }
            return .commandFailed
        }
        
        commandCenter.previousTrackCommand.addTarget { [unowned self] event in
            return .success
        }
        
        commandCenter.nextTrackCommand.addTarget { [unowned self] event in
            return .success
        }
        
        commandCenter.changePlaybackPositionCommand.addTarget { [unowned self] event in
            let event1 = event as! MPChangePlaybackPositionCommandEvent
            let postionTimeSeconds = Int(event1.positionTime)
            var fsstream = FSStreamPosition()
            fsstream.second = UInt32(postionTimeSeconds)
            self.audioStream?.seek(to: fsstream)
            self.current = fsstream.second
            return .success
        }
        
//        commandCenter.seekForwardCommand.addTarget { [unowned self] event in
//            self.audioStream?.seek(to: event.timestamp)
//            return .success
//        }
    }
    
    func setupNowPlaying() {
        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = "We are your nignt"
        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = "hhhhhhhh"
        imageView.sd_setImage(with: URL(string: "https://is4-ssl.mzstatic.com/image/thumb/Music113/v4/01/9b/c1/019bc110-b53d-9da2-d987-945f5fafcf95/source/600x600bb.jpg") ) { (image, err, cacheType, url) in
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork.init(image: image!)
            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.current
            nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = 212
            nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1
            // Set the metadata
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        }
    }
    
    func updateNowPlaying() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = current
    }
    
    @IBAction func play(_ sender: UIButton) {
        if (audioStream?.isPlaying())! {
            return
        }
        if isInit {
            audioStream!.play()
            isInit = false
        } else {
            audioStream?.pause()
        }
        
    }

    @IBAction func pause(_ sender: UIButton) {
        if !(audioStream?.isPlaying())! {
            return
        }
        audioStream!.pause()
    }

}
