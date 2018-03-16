//
//  SortControlScroll.swift
//  TGOSwift
//
//  Created by 家乐淘 on 2018/3/12.
//  Copyright © 2018年 家乐淘. All rights reserved.
//

import UIKit

class SortControlScroll: UIScrollView {
    
    var dataArray = NSArray()
    var lastIndex = 10
    var directLabel = UILabel()
    var originWidth : CGFloat?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        directLabel.backgroundColor = UIColor.red
        self.addSubview(directLabel)
    }
    override func didMoveToSuperview() {
        
        print(self.dataArray.count)
        var frameX = 0
        
        for i in 0...(self.dataArray.count-1)
        {
            let title = self.dataArray[i] as! String
            let count = title.count
            print(count)
            
            let btn = UIButton.init(type: UIButtonType.custom)
            btn.setTitle(title, for: UIControlState.normal)
            btn.setTitleColor(UIColor.black, for: UIControlState.normal)
            btn.tag = i+10
            btn.addTarget(self, action: #selector(btnClick(sender:)), for: UIControlEvents.touchUpInside)
            btn.frame = CGRect.init(x: frameX, y: 0, width: count*16+20, height: 30)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.titleLabel?.textAlignment = NSTextAlignment.center
            self.addSubview(btn)
            frameX = frameX + count*16 + 20
            if btn.tag == self.lastIndex{
                
                self.directLabel.center = CGPoint.init(x: btn.center.x, y: self.bounds.size.height-6)
                self.directLabel.bounds = CGRect.init(x: 0, y: 0, width: count*16, height: 5)
                btn.setTitleColor(UIColor.orange, for: UIControlState.normal)
                originWidth = CGFloat(count*16)
            }
        }
        self.contentSize = CGSize.init(width: frameX, height: 40)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func btnClick(sender:UIButton) -> Void{
        
        if self.lastIndex != sender.tag {
            
            let btn = self.viewWithTag(lastIndex) as! UIButton
            btn.setTitleColor(UIColor.black, for: UIControlState.normal)
            sender.setTitleColor(UIColor.orange, for: UIControlState.normal)
            lastIndex = sender.tag
            
            self.setDirectLabel(sender: sender)
            self.changeOffset(index: sender.tag)
        }
    }
    
    func changeOffset(index:Int) -> Void {
        
        let btn = self.viewWithTag(index) as! UIButton
        
        let screenCenterX = SCREEN_WIDTH/2
        let btnCenterX = btn.center.x
        let shortValue = btnCenterX - screenCenterX
        let maxValue = self.contentSize.width - SCREEN_WIDTH
        
        if shortValue < 0 || self.contentSize.width <= SCREEN_WIDTH{
            self.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        }
        else if shortValue > maxValue{
            self.setContentOffset(CGPoint.init(x: maxValue, y: 0), animated: true)
        }
        else{
            self.setContentOffset(CGPoint.init(x: shortValue, y: 0), animated: true)
        }
        
    }
    func setDirectLabel(sender:UIButton) -> Void {
        
        let count = sender.titleLabel?.text?.count
        let kuan = count!*16
        //let width = self.directLabel.frame.size.width
        let scale = CGFloat(kuan)/originWidth!
        
        UIView.animate(withDuration: 0.5, animations: {
            self.directLabel.center = CGPoint.init(x: sender.center.x, y: self.bounds.size.height-6)
            self.directLabel.transform = CGAffineTransform.init(scaleX: scale, y: 1)
        })
        
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
