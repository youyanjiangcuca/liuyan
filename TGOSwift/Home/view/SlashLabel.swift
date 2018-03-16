//
//  SlashLabel.swift
//  TGOSwift
//
//  Created by 家乐淘 on 2018/2/23.
//  Copyright © 2018年 家乐淘. All rights reserved.
//

import UIKit

class SlashLabel: UILabel {
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//
//    }
//    override func didMoveToSuperview() {
//
//
//    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //print(self.frame.size.height)
        var context = UIGraphicsGetCurrentContext()
        //设定颜色
        context?.setStrokeColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0)
        context?.setLineWidth(2)
        context?.beginPath()
        //起始位置
        context?.move(to: CGPoint.init(x: 0, y: self.frame.size.height/2-3))
        //移动到
        context?.addLine(to: CGPoint.init(x: self.bounds.size.width, y: self.frame.size.height/2+3))
        
        //描绘
        context?.strokePath()
    }
    

}
