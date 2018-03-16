//
//  EverySpecialView.swift
//  TGOSwift
//
//  Created by 家乐淘 on 2018/2/23.
//  Copyright © 2018年 家乐淘. All rights reserved.
//

import UIKit

class EverySpecialView: UIView {
    var dataDic = NSDictionary()
    
    //初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    //添加到主视图
    override func didMoveToSuperview() {
        self.createTopView()
        self.createScroll()
    }
    func createScroll() -> Void {
        
        let array = dataDic["list"] as! NSArray
        
        let scroll = UIScrollView()
        scroll.frame = CGRect.init(x: 0, y: 65, width: SCREEN_WIDTH, height: 155)
        //scroll.backgroundColor = UIColor.orange
        scroll.contentSize = CGSize.init(width: 150*array.count, height: 155)
        scroll.bounces = false
        self.addSubview(scroll)
        
        
        if array.count > 0 {
            
            for i in 0...(array.count-1){
                
                let goodsData = array[i] as! NSDictionary
                
                let goodsView = EveryGoodsView()
                goodsView.tag = i
                //goodsView.backgroundColor = UIColor.red
                goodsView.dataDic = goodsData
                goodsView.frame = CGRect.init(x: i*150, y: 0, width: 150, height: 155)
                scroll.addSubview(goodsView)
                
                let gesture = UITapGestureRecognizer.init(target: self, action: #selector(gotoGoodsDetail(sender:)))
                
                goodsView.addGestureRecognizer(gesture)
            }
            
        }
        
        
        
    }
    func createTopView() -> Void {
        
        let signImage = UIImageView()
        signImage.image = UIImage.init(named: "everySpecial")
        self.addSubview(signImage)
        
        let signLabel = UILabel()
        signLabel.text = "天天特价"
        signLabel.textColor = UIColor.black
        signLabel.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(signLabel)
        
        let describleLabel = UILabel()
        describleLabel.text = "每日特价，好货不断"
        describleLabel.font = UIFont.systemFont(ofSize: 11)
        describleLabel.textColor = UIColor.gray
        self.addSubview(describleLabel)
        
        let moreGoodsBtn = UIButton()
        moreGoodsBtn.setTitle("更多商品", for: UIControlState.normal)
        moreGoodsBtn.setTitleColor(UIColor.red, for: UIControlState.normal)
        moreGoodsBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        moreGoodsBtn.addTarget(self, action: #selector(getMoreGoods), for: UIControlEvents.touchUpInside)
        self.addSubview(moreGoodsBtn)
        
        let rightBtn = UIButton()
        rightBtn.setImage(UIImage.init(named: "rightRedBack"), for: UIControlState.normal)
        rightBtn.addTarget(self, action: #selector(getMoreGoods), for: UIControlEvents.touchUpInside)
        self.addSubview(rightBtn)
        
        signImage.snp.makeConstraints { (make) in
            make.left.equalTo(WIDTH(num: 30))
            make.top.equalTo(WIDTH(num: 20))
            make.width.equalTo(WIDTH(num: 40))
            make.height.equalTo(WIDTH(num: 50))
        }
        
        signLabel.snp.makeConstraints { (make) in
            make.left.equalTo(signImage.snp.right).offset(WIDTH(num: 20))
            make.top.equalTo(signImage.snp.top).offset(0)
        }
        
        describleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(signLabel.snp.left).offset(0)
            make.top.equalTo(signLabel.snp.bottom).offset(5)
        }
        
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalTo(WIDTH(num: -15))
            make.top.equalTo(signImage.snp.top).offset(0)
            make.width.equalTo(WIDTH(num: 12))
            make.height.equalTo(WIDTH(num: 12))
        }
        
        moreGoodsBtn.snp.makeConstraints { (make) in
            make.right.equalTo(rightBtn.snp.left).offset(-5)
            make.top.equalTo(rightBtn.snp.top).offset(0)
            make.height.equalTo(14)
        }
        
    }
    @objc func gotoGoodsDetail(sender:UITapGestureRecognizer) -> Void{
        print("商品详情")
        let view = sender.view
        print(view?.tag ?? "00")
        
    }
    
    @objc func getMoreGoods() -> Void {
        print("获取更多商品")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
