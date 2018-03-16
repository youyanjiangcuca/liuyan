//
//  SortScrollView.swift
//  TGOSwift
//
//  Created by 家乐淘 on 2018/1/30.
//  Copyright © 2018年 家乐淘. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

protocol SortScrollViewDelegate:NSObjectProtocol {
    func getDetailSort(dic:NSDictionary)
}

class SortScrollView: UIScrollView ,UIScrollViewDelegate{
    var dataArray:NSArray!
    var pageC:UIPageControl!
    weak var clickDelegate: SortScrollViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = (self as UIScrollViewDelegate)
        self.pageC = UIPageControl.init()
        pageC.center = CGPoint.init(x: self.bounds.width/2, y: self.bounds.height-11)
        self.pageC.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 20);
        self.pageC.pageIndicatorTintColor = UIColor.gray
        self.pageC.currentPageIndicatorTintColor = UIColor.black
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func didMoveToSuperview() {
        
        self.superview?.addSubview(self.pageC)
        
        if self.dataArray.count > 0
        {
            self.pageC.numberOfPages = (self.dataArray.count-1)/8+1
            
            for i in 0...(self.dataArray.count-1)
            {
                let dic = self.dataArray[i] as! NSDictionary
                let str = dic["cat_photo"] as! String
                let urlStr = String(HttpManager.ERPBaseUrl+str)
                
                let view = UIView()
                view.tag = i
                self.addSubview(view)
                
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(btnClick(sender:)))
                view.addGestureRecognizer(tap)
                
                
                let imageV = UIImageView.init()
                imageV.kf.setImage(with: ImageResource.init(downloadURL: URL(string: urlStr)!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, type, url) in
                    
                })
                view.addSubview(imageV)
                
                let label = UILabel.init()
                label.text = dic["cat_name"] as? String
                label.font = UIFont.systemFont(ofSize: 12)
                label.textAlignment = NSTextAlignment.center
                view.addSubview(label)
                
//                let frameX = CGFloat(i/8)*SCREEN_WIDTH + CGFloat(i%4)*SCREEN_WIDTH/4+SCREEN_WIDTH/8
//                let frameY = i/4%2*70
                
                let frameW = CGFloat(i/8)*SCREEN_WIDTH + CGFloat(i%4)*SCREEN_WIDTH/4
                let frameH = i/4%2*70
                
                
                view.snp.makeConstraints({ (make) in
                    make.left.equalTo(frameW)
                    make.top.equalTo(frameH)
                    make.width.equalTo(SCREEN_WIDTH/4)
                    make.height.equalTo(70)
                })
                
                imageV.snp.makeConstraints({ (make) in
                    make.centerX.equalTo(view.snp.centerX).offset(0)
                    make.top.equalTo(10)
                    make.width.equalTo(30)
                    make.height.equalTo(30)
                })
                
                label.snp.makeConstraints({ (make) in
                    make.centerX.equalTo(view.snp.centerX).offset(0)
                    make.top.equalTo(imageV.snp.bottom).offset(10)
                })
//                imageV.snp.makeConstraints({ (make) in
//                    make.centerX.equalTo(frameX)
//                    make.top.equalTo(frameY+10)
//                    make.width.equalTo(30)
//                    make.height.equalTo(30)
//                })
//
//                label.snp.makeConstraints({ (make) in
//                    make.centerX.equalTo(imageV.snp.centerX)
//                    make.top.equalTo(imageV.snp.bottom).offset(10)
//                })
            }
        }
    }
    @objc func btnClick(sender:UITapGestureRecognizer) -> Void {
        print(sender.view?.tag ?? "00")
        let dic = self.dataArray[(sender.view?.tag)!] as! NSDictionary
        self.clickDelegate?.getDetailSort(dic:dic)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageC.currentPage = Int(scrollView.contentOffset.x/SCREEN_WIDTH)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
