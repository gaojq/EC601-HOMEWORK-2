//
//  ChoosePhotoViewController.swift
//  PhotoChoose
//
//  Created by Jianqing Gao on 9/28/16.
//  Copyright © 2016 Jianqing Gao. All rights reserved.
//

import UIKit
import AVFoundation

class ChoosePhotoViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onChooseCamera(_ sender: AnyObject) {
        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        if status == .denied {
            let alertVC = UIAlertController(title: "提示", message: "应用未获取到相机使用权限，是否立即设置？", preferredStyle: .alert);
            let setAction = UIAlertAction(title: "立即设置", style: .default, handler: { (UIAlertAction) in
                let setURL = URL(string: UIApplicationOpenSettingsURLString)
                if UIApplication.shared.canOpenURL(setURL!) {
                    UIApplication.shared.open(setURL!, options: [:], completionHandler: nil)
                }
            })
            let cancelAction = UIAlertAction(title: "不", style: .cancel, handler: { (UIAlertAction) in
                
            })
            alertVC.addAction(setAction)
            alertVC.addAction(cancelAction)
            self.present(alertVC, animated: true, completion: nil)
            return
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let pickerVC = UIImagePickerController()
            pickerVC.sourceType = .camera
            pickerVC.delegate = self
            self.present(pickerVC, animated: true, completion: nil)
        }else{
            let alertVC = UIAlertController(title: "提示", message: "设备不支持摄像头", preferredStyle: .alert);
            let cancelAction = UIAlertAction(title: "好", style: .cancel, handler: { (UIAlertAction) in
                
            })
            alertVC.addAction(cancelAction)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func onChooseLibrary(_ sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerVC = UIImagePickerController()
            pickerVC.sourceType = .photoLibrary
            pickerVC.delegate = self
            self.present(pickerVC, animated: true, completion: nil)
        }else{
            let alertVC = UIAlertController(title: "提示", message: "设备没有相册", preferredStyle: .alert);
            let cancelAction = UIAlertAction(title: "好", style: .cancel, handler: { (UIAlertAction) in
                
            })
            alertVC.addAction(cancelAction)
            self.present(alertVC, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageObj = info[UIImagePickerControllerOriginalImage]
        let image = imageObj as! UIImage?
        imageView.image = image
        if picker.sourceType == .camera {
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
}
