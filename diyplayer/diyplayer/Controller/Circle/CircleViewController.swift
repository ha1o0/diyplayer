//
//  CircleViewController.swift
//  diyplayer
//
//  Created by sidney on 2019/12/7.
//  Copyright © 2019 sidney. All rights reserved.
//

import UIKit
import SDWebImage

class CircleViewController: CustomViewController {

    @IBOutlet weak var bkgImageView: UIImageView!
    var currentImageIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func popList(_ sender: UIButton) {
        let musicListPopController = MusicListViewController()
        musicListPopController.modalPresentationStyle = .overCurrentContext
        present(musicListPopController, animated: true, completion: nil)
    }
    
    @IBAction func changeImage(_ sender: UIButton) {
        let imageUrls = [
            "https://is4-ssl.mzstatic.com/image/thumb/Music113/v4/01/9b/c1/019bc110-b53d-9da2-d987-945f5fafcf95/source/600x600bb.jpg",
            "https://is1-ssl.mzstatic.com/image/thumb/Music113/v4/8d/17/8f/8d178ff3-cef4-b633-eeb6-55fbb2f75d35/source/600x600bb.jpg",
            "https://is4-ssl.mzstatic.com/image/thumb/Music123/v4/ce/f5/d0/cef5d0a0-3e26-29b4-20d2-b73cd636604c/source/600x600bb.jpg"
        ]
        bkgImageView?.sd_setImage(with: URL(string: imageUrls[currentImageIndex]), placeholderImage: bkgImageView.image, options: SDWebImageOptions()) { (image, error, type, url) in
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            self.bkgImageView.layer.add(transition, forKey: "a")
            self.bkgImageView.image = image
            self.currentImageIndex += 1
            if self.currentImageIndex == imageUrls.count {
                self.currentImageIndex = 0
            }
        }
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
