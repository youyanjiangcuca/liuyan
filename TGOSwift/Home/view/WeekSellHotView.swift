//
//  WeekSellHotView.swift
//  TGOSwift
//
//  Created by 家乐淘 on 2018/2/28.
//  Copyright © 2018年 家乐淘. All rights reserved.
//

import UIKit
import Kingfisher
class WeekSellHotView: UIView {
    
    var dataDic = NSDictionary()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func didMoveToSuperview() {
        self.createTopView()
        self.createBottomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func createTopView() -> Void {
        
        let signImage = UIImageView()
        signImage.image = UIImage.init(named: "weekHot")
        self.addSubview(signImage)
        
        let signLabel = UILabel()
        signLabel.text = "一周热销榜"
        signLabel.textColor = UIColor.black
        signLabel.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(signLabel)
        
        let describleLabel = UILabel()
        describleLabel.text = "所有的好物值得分享"
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
    
    func createBottomView() -> Void {
        let array = dataDic["list"] as! NSArray
        let dic = array[0] as! NSDictionary
        self.createMainView(dic: dic)
        
        if array.count >= 3 {
            
            for i in 1...2{
               let dic = array[i] as! NSDictionary
                let view = WeekGoodsView.init(frame: CGRect.init(x: CGFloat(i-1)*SCREEN_WIDTH/2, y: 260, width: SCREEN_WIDTH/2, height: 180))
                view.dataDic = dic
                self.addSubview(view)
                
            }
        }
        
        
        
    }
    func createMainView(dic:NSDictionary) -> Void {
        
        let view = UIView()
        self.addSubview(view)
        
        view.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(60)
            make.height.equalTo(200)
        }
        
        let imageV = UIImageView.init()
        imageV.backgroundColor = UIColor.orange
        let str = dic["goods_photo"] as! String
        let urlStr = String(HttpManager.ERPBaseUrl+str)
        imageV.kf.setImage(with: ImageResource.init(downloadURL: URL(string: urlStr)!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        view.addSubview(imageV)
        
        let nameLabel = UILabel()
        nameLabel.text = (dic["goods_name"] as! String)
        nameLabel.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(nameLabel)
        
        let amountLabel = UILabel()
        let num = dic["sales"] as! String
        
        amountLabel.text = String("月销量"+num+"笔")
        amountLabel.textColor = UIColor.gray
        amountLabel.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(amountLabel)
        
        let salePrice = UILabel()
        let salePriceNum = dic["sale_price"] as! String
        let price = Float(salePriceNum)
        let signPrice = String(format: "%.2f", price!/100)
        salePrice.text = String("￥"+signPrice)
        salePrice.textColor = UIColor.red
        salePrice.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(salePrice)
        
        let superPrice = SlashLabel()
        
        let marketPrice = dic["market_price"] as! String
        let price2 = Float(marketPrice)
        let signPrice2 = String(format: "%.2f", price2!/100)
        
        superPrice.textColor = UIColor.gray
        superPrice.font = UIFont.systemFont(ofSize: 12)
        superPrice.text = String("￥"+signPrice2)
        
        view.addSubview(superPrice)
        
        let saleLabel = UILabel()
        saleLabel.textColor = UIColor.red
        saleLabel.text = "T购价"
        saleLabel.font = UIFont.systemFont(ofSize: 11)
        view.addSubview(saleLabel)
        
        let superLabel = UILabel()
        superLabel.textColor = UIColor.gray
        superLabel.font = UIFont.systemFont(ofSize: 11)
        superLabel.text = "超市价"
        view.addSubview(superLabel)
        
        imageV.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(10)
            make.height.equalTo(140)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(imageV.snp.bottom).offset(10)
        }
        
        amountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        
        salePrice.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(nameLabel.snp.top)
        }
        
        superPrice.snp.makeConstraints { (make) in
            make.right.equalTo(salePrice.snp.right)
            make.top.equalTo(amountLabel.snp.top)
        }
        
        saleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(salePrice.snp.left).offset(-3)
            make.top.equalTo(salePrice.snp.top)
        }
        
        superLabel.snp.makeConstraints { (make) in
            make.right.equalTo(superPrice.snp.left).offset(-3)
            make.top.equalTo(superPrice.snp.top)
        }
        
    }
    @objc func getMoreGoods() -> Void {
        print("获取更多商品")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
