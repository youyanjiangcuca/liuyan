//
//  EveryGoodsView.swift
//  TGOSwift
//
//  Created by 家乐淘 on 2018/2/23.
//  Copyright © 2018年 家乐淘. All rights reserved.
//

import UIKit
import Kingfisher
class EveryGoodsView: UIView {
    var dataDic = NSDictionary()
    let goodsImage = UIImageView()
    let goodsName = UILabel()
    let goodsPrice = UILabel()
    let superPrice = SlashLabel()
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func didMoveToSuperview() {
        
        self.goodsImage.image = UIImage.init(named: "goodsPlaceholder")
        let url = self.dataDic["goods_photo"] as! String
        let completeUrl = String(HttpManager.ERPBaseUrl+url)
        
        self.goodsImage.kf.setImage(with: ImageResource.init(downloadURL: URL(string: completeUrl)!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, type, url) in
            
        })
        self.addSubview(self.goodsImage)
        
        self.goodsName.text = (self.dataDic["goods_name"] as! String)
        self.goodsName.numberOfLines = 2
        //self.goodsName.textAlignment = NSTextAlignment.center
        //self.goodsName.backgroundColor = UIColor.red
        self.goodsName.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(self.goodsName)
        
        self.goodsPrice.textColor = UIColor.red
        let salePrice = self.dataDic["sale_price"] as! String
        let price = Float(salePrice)
        let signPrice = String(format: "%.2f", price!/100)
        
        self.goodsPrice.text = String("￥"+signPrice)
        self.goodsPrice.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(self.goodsPrice)
        
        self.superPrice.textColor = UIColor.gray
        let marketPrice = self.dataDic["market_price"] as! String
        let price2 = Float(marketPrice)
        let signPrice2 = String(format: "%.2f", price2!/100)
        self.superPrice.text = String("￥"+signPrice2)
        self.superPrice.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(self.superPrice)
        
        let priceLabel = UILabel()
        priceLabel.text = "T购价"
        priceLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(priceLabel)
        
        let superLabel = UILabel()
        superLabel.text = "超市价"
        superLabel.textColor = UIColor.gray
        superLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(superLabel)
        
        self.goodsImage.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(80)
        }
        
        self.goodsName.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(self.goodsImage.snp.bottom).offset(0)
           // make.right.equalTo(-10)
            make.width.equalTo(self.bounds.size.width-15)
        }
        
        superLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.bottom.equalTo(-5)
        }
        
        self.superPrice.snp.makeConstraints { (make) in
            make.right.equalTo(-5)
            make.bottom.equalTo(-5)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.bottom.equalTo(superLabel.snp.top).offset(-5)
        }
        
        self.goodsPrice.snp.makeConstraints { (make) in
            make.right.equalTo(-5)
            make.bottom.equalTo(self.superPrice.snp.top).offset(-5)
        }
        
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
