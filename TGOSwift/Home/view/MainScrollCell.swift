//
//  MainScrollCell.swift
//  TGOSwift
//
//  Created by 家乐淘 on 2018/3/8.
//  Copyright © 2018年 家乐淘. All rights reserved.
//

import UIKit
import Kingfisher
class MainScrollCell: UITableViewCell {
    
    let goodsImage = UIImageView()
    let nameLabel = UILabel()
    let salePrice = UILabel()
    let superPrice = SlashLabel()
    let amountLabel = UILabel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        //self.backgroundColor = UIColor.orange
        
        self.goodsImage.backgroundColor = UIColor.red
        self.addSubview(self.goodsImage)
        
        self.nameLabel.font = UIFont.systemFont(ofSize: 14)
        self.nameLabel.numberOfLines = 0
        self.addSubview(self.nameLabel)
        
        self.salePrice.textColor = UIColor.red
        self.salePrice.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(self.salePrice)
        
        self.superPrice.textColor = UIColor.gray
        self.superPrice.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(self.superPrice)
        
        self.amountLabel.textColor = UIColor.gray
        self.amountLabel.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(self.amountLabel)
        
        self.setUpViews()
    }
    func setUpViews() -> Void {
        
        self.goodsImage.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(150)
        }
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.goodsImage.snp.right).offset(10)
            make.right.equalTo(-10)
            make.top.equalTo(10)
        }
        self.salePrice.snp.makeConstraints { (make) in
            make.left.equalTo(self.goodsImage.snp.right).offset(0)
            make.bottom.equalTo(-5)
        }
        self.superPrice.snp.makeConstraints { (make) in
            make.left.equalTo(self.salePrice.snp.right).offset(5)
            make.bottom.equalTo(self.salePrice.snp.bottom).offset(0)
        }
        self.amountLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.bottom.equalTo(-5)
        }
       
    }
    func setData(dic:NSDictionary) -> Void {
        let partUrl = dic["goods_photo"] as! String
        let allUrl = String(HttpManager.ERPBaseUrl+partUrl)
        
        self.goodsImage.kf.setImage(with: ImageResource.init(downloadURL: URL(string:allUrl)!), placeholder: nil, options: nil, progressBlock: nil) { (image, error, type, url) in
            
        }
        
        self.nameLabel.text = (dic["goods_name"] as! String)
        let price = dic["sale_price"] as! String
        let priceNum = Float(price)
        self.salePrice.text = "￥" + String(format:"%.2f",priceNum!/100)
        
        let price2 = dic["market_price"] as! String
        let price2Num = Float(price2)
        self.superPrice.text = "￥" + String(format:"%.2f",price2Num!/100)
        
        let sales = dic["sales"] as! String
        self.amountLabel.text = String("月销量"+sales+"笔")
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
