//
//  MainScroll.swift
//  TGOSwift
//
//  Created by 家乐淘 on 2018/1/25.
//  Copyright © 2018年 家乐淘. All rights reserved.
//

import UIKit
import Kingfisher

protocol MainScrollDelegate:NSObjectProtocol {
    func getMainScrollGoods(index:Int)
}

class MainScroll: UIScrollView,UIScrollViewDelegate {
    
    
    //存储图片链接
    var dataArray:NSArray = NSArray()
    var timer:Timer!
    var pageC:UIPageControl!
    weak var clickDelegate: MainScrollDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = (self as UIScrollViewDelegate)
        
      
    }
    
    override func didMoveToSuperview() {
        print("加载到主视图")
        self.createChildControl()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.pageC.currentPage = Int(scrollView.contentOffset.x/SCREEN_WIDTH)
        self.timer.fireDate = Date(timeIntervalSinceNow:1.5)
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.5) {
//            self.timer.fireDate = Date.distantPast
//        }
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.timer.fireDate = Date.distantFuture
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createChildControl()->Void{
        if self.dataArray.count > 0 {
            var i = 0
            
            for str in self.dataArray
            {
                
                let Str = str as! String
                
                let urlStr = String(HttpManager.ERPBaseUrl+Str)
                
                let image = UIImageView.init(frame: CGRect.init(x: CGFloat(i)*SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: self.bounds.size.height))
                image.kf.setImage(with: ImageResource.init(downloadURL: URL(string: urlStr)!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, type, url) in
                    
                })
                image.isUserInteractionEnabled = true
                image.tag = i
                self.addSubview(image)
                
                let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(imageClick(sender:)))
                image.addGestureRecognizer(tapGesture)
                
                i = i+1
                
            }
            //创建指示器
            self.pageC = UIPageControl.init()
            self.pageC.center = CGPoint.init(x: self.center.x, y: self.frame.origin.y+self.frame.size.height-20)
            self.pageC.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 20)
            //self.pageC.backgroundColor = UIColor.white
            self.pageC.numberOfPages = self.dataArray.count
            self.pageC.currentPageIndicatorTintColor = UIColor.black
            self.pageC.pageIndicatorTintColor = UIColor.brown
            self.superview?.addSubview(self.pageC)
            
            //创建定时器
            timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { (timer) in
                //let offset = self.contentOffset.x
                //if offset == CGFloat(self.dataArray.count-1)*SCREEN_WIDTH
                    if self.pageC.currentPage == self.dataArray.count-1
                {
                    self.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
                    self.pageC.currentPage = 0
                    //self.timer.fireDate = Date.distantFuture
                    
                }
                else
                {
                    
                    self.pageC.currentPage = self.pageC.currentPage+1
                    self.setContentOffset(CGPoint.init(x: CGFloat(self.pageC.currentPage)*SCREEN_WIDTH, y: 0), animated: true)
                    
                }

            })
           
        }
        else
        {
            
        }
    }
    @objc func imageClick(sender:UITapGestureRecognizer)->Void{
        let view = sender.view
        print(view?.tag ?? "00")
        self.clickDelegate?.getMainScrollGoods(index: (view?.tag)!)
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
