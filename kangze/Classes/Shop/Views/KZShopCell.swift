//
//  KZShopCell.swift
//  kangze
//  商城 商品cell
//  Created by gouyz on 2018/8/29.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

class KZShopCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = kWhiteColor
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(iconView)
        contentView.addSubview(nameLab)
        contentView.addSubview(saleLab)
        contentView.addSubview(priceLab)
        contentView.addSubview(payNumberLab)
        
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.top.equalTo(kMargin)
            make.size.equalTo(CGSize.init(width: 100, height: 100))
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(kMargin)
            make.top.equalTo(iconView)
            make.right.equalTo(-kMargin)
            make.height.equalTo(kTitleHeight)
        }
        saleLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLab)
            make.top.equalTo(nameLab.snp.bottom)
            make.height.equalTo(20)
        }
        priceLab.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab)
            make.bottom.equalTo(iconView)
            make.height.equalTo(20)
            make.width.equalTo(80)
        }
        payNumberLab.snp.makeConstraints { (make) in
            make.left.equalTo(priceLab.snp.right)
            make.bottom.height.equalTo(priceLab)
            make.right.equalTo(-kMargin)
        }
    }
    
    /// 商品图标
    lazy var iconView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_shop_default"))
    
    /// 商品类型
    lazy var typeLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kRedFontColor
        lab.text = "合伙人套餐"
        
        return lab
    }()
    
    /// 商品名称
    lazy var nameLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kBlackFontColor
        lab.numberOfLines = 2
        
        return lab
    }()
    /// 月销
    lazy var saleLab : UILabel = {
        let lab = UILabel()
        lab.font = k12Font
        lab.textColor = kGaryFontColor
        lab.text = "月销4578件"
        
        return lab
    }()
    /// 单价
    lazy var priceLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kRedFontColor
        lab.text = "￥298"
        
        return lab
    }()
    /// 付款人数
    lazy var payNumberLab : UILabel = {
        let lab = UILabel()
        lab.font = k12Font
        lab.textColor = kGaryFontColor
        lab.text = "1258人付款"
        
        return lab
    }()
}
