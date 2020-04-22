//
//  ChannelViewController.swift
//  diyplayer
//
//  Created by sidney on 2019/7/21.
//  Copyright © 2019 sidney. All rights reserved.
//

import UIKit
import FreeStreamer
import SuperPlayer

class ChannelViewController: CustomViewController, SuperPlayerDelegate {

    var musicUrl = "http://www.0dutv.com/plug/down/up2.php/105030812.mp3"
    var audioStream: FSAudioStream?
    var isInit: Bool = true
    var superView: SuperPlayerView = SuperPlayerView()
    var playModel: SuperPlayerModel = SuperPlayerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(superView)
        superView.snp.makeConstraints { (maker) in
//            maker.width.equalTo(1)
//            maker.height.equalTo(1)
//            maker.center.equalToSuperview()
            maker.bottom.equalToSuperview().offset(34)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.height.equalTo(200)
        }
        superView.delegate = self
        superView.isHidden = true
        playModel.videoURL = musicUrl
//        audioStream = FSAudioStream.init(url: URL(string: musicUrl))
        // Do any additional setup after loading the view.
    }


    @IBAction func play(_ sender: UIButton) {
        if superView.state == .StatePlaying {
            return
        }
        if isInit {
            superView.play(with: playModel)
            isInit = false
        } else {
            superView.resume()
        }
//        if (audioStream?.isPlaying())! {
//            return
//        }
//        if isInit {
//            audioStream!.play()
//            isInit = false
//        } else {
//            audioStream?.pause()
//        }
        
    }

    @IBAction func pause(_ sender: UIButton) {

            superView.pause()

//        if !(audioStream?.isPlaying())! {
//            return
//        }
//        audioStream!.pause()
    }

}
