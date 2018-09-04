//
//  KZOrderCell.swift
//  kangze
//  我的订单 cell
//  Created by gouyz on 2018/9/3.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

class KZOrderCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = kBackgroundColor
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(iconView)
        contentView.addSubview(nameLab)
        contentView.addSubview(numberLab)
        contentView.addSubview(priceLab)
        
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.centerY.equalTo(contentView)
            make.size.equalTo(CGSize.init(width: 80, height: 80))
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(kMargin)
            make.top.equalTo(iconView)
            make.right.equalTo(-kMargin)
        }
        priceLab.snp.makeConstraints { (make) in
            make.top.equalTo(nameLab.snp.bottom).offset(kMargin)
            make.left.equalTo(nameLab)
            make.right.equalTo(numberLab.snp.left).offset(-kMargin)
            make.height.equalTo(20)
        }
        numberLab.snp.makeConstraints { (make) in
            make.right.equalTo(nameLab)
            make.top.height.top.equalTo(priceLab)
            make.width.equalTo(80)
        }
    }
    /// 图标
    lazy var iconView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_goods_default"))
    
    /// cell title
    lazy var nameLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kBlackFontColor
        lab.numberOfLines = 3
        lab.text = "澳洲原装天然海藻油DHA帮助大脑发育增强记忆降低血糖全球妈妈的首选"
        
        return lab
    }()
    
    /// 数量
    lazy var numberLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kGaryFontColor
        lab.textAlignment = .right
        lab.text = "x1"
        
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
}
