//
//  ChannelViewController.swift
//  diyplayer
//
//  Created by sidney on 2019/7/21.
//  Copyright © 2019 sidney. All rights reserved.
//

import UIKit
import FreeStreamer

class ChannelViewController: CustomViewController {

    var musicUrl = "http://www.0dutv.com/plug/down/up2.php/105030812.mp3"
    var audioStream: FSAudioStream?
    var isInit: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioStream = FSAudioStream.init(url: URL(string: musicUrl))
        // Do any additional setup after loading the view.
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
