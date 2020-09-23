//
//  CircleViewController.swift
//  diyplayer
//
//  Created by sidney on 2019/12/7.
//  Copyright © 2019 sidney. All rights reserved.
//

import UIKit
import SDWebImage
import ZImageCropper

class CircleViewController: CustomViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {


    @IBOutlet weak var bkgImageView: ZImageCropperView!
    var currentImageIndex: Int = 0
    var after: UIImage?
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func popList(_ sender: UIButton) {
        let musicListPopController = MusicListViewController()
        musicListPopController.modalPresentationStyle = .overCurrentContext
        present(musicListPopController, animated: true, completion: nil)
    }
    
    @IBAction func toCollectionView(_ sender: UIButton) {
        self.after = bkgImageView.cropImage()
        self.bkgImageView.image = self.after
        bkgImageView.resetCrop()
//        UIImageWriteToSavedPhotosAlbum(after!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
//        let success = saveImage(image: after)
//        let vc = GoodDetailViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func toCornerShadowVc(_ sender: UIButton) {
        bkgImageView.resetCrop()
    }
    
    @IBAction func changeImage(_ sender: UIButton) {

//        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
//            print("Button capture")
//
//            imagePicker.delegate = self
//            imagePicker.sourceType = .savedPhotosAlbum
//            imagePicker.allowsEditing = false
//
//            present(imagePicker, animated: true, completion: nil)
//        }
        let imageUrls = [
            "https://is4-ssl.mzstatic.com/image/thumb/Music113/v4/01/9b/c1/019bc110-b53d-9da2-d987-945f5fafcf95/source/600x600bb.jpg",
            "https://is1-ssl.mzstatic.com/image/thumb/Music113/v4/8d/17/8f/8d178ff3-cef4-b633-eeb6-55fbb2f75d35/source/600x600bb.jpg",
            "https://is4-ssl.mzstatic.com/image/thumb/Music123/v4/ce/f5/d0/cef5d0a0-3e26-29b4-20d2-b73cd636604c/source/600x600bb.jpg"
        ]
        let newImageView = UIImageView();
        newImageView.sd_setImage(with: URL(string: imageUrls[currentImageIndex]), placeholderImage: bkgImageView.image, options: SDWebImageOptions()) { (image, error, type, url) in
            let new = (self.after?.overlayWith(image: image!, posX: 50, posY: 50))!
            UIImageWriteToSavedPhotosAlbum(new, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
//            let transition = CATransition()
//            transition.duration = 0.5
//            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//            self.bkgImageView.layer.add(transition, forKey: "a")
//            self.bkgImageView.image = image
//            self.currentImageIndex += 1
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

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {

        self.dismiss(animated: true, completion: { () -> Void in
        })
        let new = self.after?.overlayWith(image: image, posX: 0, posY: 0)
        UIImageWriteToSavedPhotosAlbum(new!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths)
        return paths[0]
    }
    
    func saveImage(image: UIImage) -> Bool {
        guard let data = UIImageJPEGRepresentation(image, 1) ?? UIImagePNGRepresentation(image) else {
            print("111111")
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            print("1111112")
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent("fileName.png")!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}


extension UIImage {

  func overlayWith(image: UIImage, posX: CGFloat, posY: CGFloat) -> UIImage {
    let newWidth = size.width < posX + image.size.width ? posX + image.size.width : size.width
    let newHeight = size.height < posY + image.size.height ? posY + image.size.height : size.height
    let newSize = CGSize(width: newWidth, height: newHeight)

    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
    draw(in: CGRect(origin: CGPoint.zero, size: size))
    image.draw(in: CGRect(origin: CGPoint(x: posX, y: posY), size: image.size))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()

    return newImage
  }

}
