//
//  PicturePreview.swift
//  ImageViewer
//
//  Created by 史凯迪 on 15/8/11.
//  Copyright © 2015年 msy. All rights reserved.
//

import UIKit

class imagePreview: UIView, UIScrollViewDelegate {
    
    private var title: UILabel = UILabel()
    private var imageScrollView: UIScrollView = UIScrollView()
    private var imageURLs: [String] = []
    private var viewFrame: CGRect!
    private var indexOfCurrentPage: Int = 1
    private var allImageView: [UIImageView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, imageURLs: [String], index: Int) {
        self.init(frame: frame)
        self.imageURLs = imageURLs
        self.viewFrame = frame
        
        self.initScrollViewItemView()
        self.addSubview(self.imageScrollView)
        
        self.initNumberTitle()
        self.addSubview(self.title)
        
        let closeTap: UITapGestureRecognizer =
        UITapGestureRecognizer(target: self,
            action: Selector("dismissImageViewer:"))
        closeTap.numberOfTapsRequired = 1
        self.addGestureRecognizer(closeTap)
        
        if index != 0 {
            if index >= self.imageURLs.count {
                return
            } else {
                let xpoint: CGFloat = CGFloat(index) * self.viewFrame.width
                self.imageScrollView.setContentOffset(CGPoint(x: xpoint, y: 0), animated: false)
                self.indexOfCurrentPage = index + 1
                self.updateNumberTitle()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: data)
            }.resume()
    }
    
    private func downloadImage(urlString: String, imageView: UIImageView, waitView: UIView?){
        let url: NSURL = NSURL(string: urlString)!
        self.getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                if let imageData: NSData = data {
                    imageView.image = UIImage(data: imageData)
                    imageView.hidden = false
                    waitView?.removeFromSuperview()
                }
            }
        }
    }
    
    private func loadImageFromNetwork(urlString: String,
        imageView: UIImageView, waitView: UIView) {
            self.downloadImage(urlString, imageView: imageView, waitView: waitView)
    }
    
    private func initScrollViewItemView() {
        let imageScrollViewFrame: CGRect = CGRect(x: self.viewFrame.origin.x,
            y: self.viewFrame.origin.y,
            width: self.viewFrame.width,
            height: self.viewFrame.height * 0.8)
        self.imageScrollView.frame = imageScrollViewFrame
        self.imageScrollView.center = self.center
        
        var xpoint: CGFloat = 0
        
        for var index = 0; index < self.imageURLs.count; index++ {
            /* 图片显示视图 */
            let imageViewFrame: CGRect = CGRect(x: xpoint, y: 0,
                width: imageScrollViewFrame.width, height: imageScrollViewFrame.height)
            let imageView: UIImageView = UIImageView(frame: imageViewFrame)
            allImageView.append(imageView)
            xpoint += imageScrollViewFrame.width
            
            let waitView: UIActivityIndicatorView = UIActivityIndicatorView()
            waitView.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
            waitView.activityIndicatorViewStyle =
                UIActivityIndicatorViewStyle.WhiteLarge
            waitView.center = CGPoint(x: self.center.x, y: self.center.y - 50)
            waitView.startAnimating()
            
            imageView.addSubview(waitView)
            self.imageScrollView.addSubview(imageView)
            /* 加载图片 */
            self.loadImageFromNetwork(self.imageURLs[index],
                imageView: imageView, waitView: waitView)
        }
        
        let width: CGFloat =
        imageScrollViewFrame.width * CGFloat(self.imageURLs.count)
        self.imageScrollView.contentSize =
            CGSizeMake(width, imageScrollViewFrame.height)
        /* 相关属性 */
        self.imageScrollView.pagingEnabled = true
        self.imageScrollView.delegate = self
        self.imageScrollView.showsHorizontalScrollIndicator = false
    }
    
    private func initNumberTitle() {
        let titleWidth: CGFloat = 100
        self.title.frame = CGRect(x: (self.frame.width - titleWidth) / 2,
            y: 25, width: titleWidth, height: 30)
        self.title.font = UIFont.boldSystemFontOfSize(20)
        self.title.textColor = UIColor.whiteColor()
        self.title.textAlignment = .Center
        self.updateNumberTitle()
    }
    
    private func updateNumberTitle() {
        self.title.text = "\(self.indexOfCurrentPage) / \(self.imageURLs.count)"
    }
    
    func dismissImageViewer(sender:UITapGestureRecognizer){
        self.title.hidden = true
        UIView.animateWithDuration(0.3, delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.backgroundColor = UIColor(white:1, alpha: 0)
                self.allImageView[self.indexOfCurrentPage - 1].alpha = 0
            }, completion: {(value:Bool) in
                self.removeFromSuperview()
        })
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let translation = scrollView.panGestureRecognizer.translationInView(scrollView).x
        
        if translation < 0 {
            if self.indexOfCurrentPage < self.imageURLs.count {
                self.indexOfCurrentPage++
            }
        } else {
            if self.indexOfCurrentPage > 1 {
                self.indexOfCurrentPage--
            }
        }
        self.updateNumberTitle()
    }
}