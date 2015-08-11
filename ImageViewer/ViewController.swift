//
//  ViewController.swift
//  ImageViewer
//
//  Created by 史凯迪 on 15/8/11.
//  Copyright © 2015年 msy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func ShowImage(sender: UIButton) {
        let mainWindow: UIWindow =
        UIApplication.sharedApplication().keyWindow! as UIWindow
        let url = ["http://dwz.cn/image1",
            "http://dwz.cn/image2",
            "http://dwz.cn/image4"]
        
        let ImageViewer: imagePreview =
            imagePreview(frame: mainWindow.frame, imageURLs: url, index: 0)
        mainWindow.addSubview(ImageViewer)
        UIView.animateWithDuration(0.3, animations:{
            ImageViewer.backgroundColor = UIColor(white:0, alpha: 1)
        })
    }
}