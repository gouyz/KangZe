//
//  KZOrderFooterView.swift
//  kangze
//  我的订单 footer 
//  Created by gouyz on 2018/9/3.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

class KZOrderFooterView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?){
        
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = kWhiteColor
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        contentView.addSubview(totalLab)
        contentView.addSubview(lineView)
        contentView.addSubview(deleteBtn)
        contentView.addSubview(operatorBtn)
        
        totalLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.top.equalTo(contentView)
            make.height.equalTo(34)
        }
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(totalLab.snp.bottom)
            make.left.right.equalTo(contentView)
            make.height.equalTo(klineWidth)
        }
        deleteBtn.snp.makeConstraints { (make) in
            make.right.equalTo(operatorBtn.snp.left).offset(-20)
            make.top.equalTo(lineView.snp.bottom).offset(8)
            make.size.equalTo(CGSize.init(width: 70, height: 20))
        }
        operatorBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kMargin)
            make.top.size.equalTo(deleteBtn)
        }
    }
    
    /// 合计
    lazy var totalLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kBlackFontColor
        lab.textAlignment = .right
        lab.text = "共2件商品  合计：￥298"
        
        return lab
    }()
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = kGrayLineColor
        
        return view
    }()
    /// 删除订单
    lazy var deleteBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = kWhiteColor
        btn.titleLabel?.font = k12Font
        btn.setTitleColor(kBlueFontColor, for: .normal)
        btn.setTitle("删除订单", for: .normal)
        btn.borderColor = kBlueFontColor
        btn.cornerRadius = kCornerRadius
        btn.borderWidth = klineWidth
        btn.addTarget(self, action: #selector(clickedDeleteBtn), for: .touchUpInside)
        
        return btn
    }()
    /// 去结算、申请发货、确认收货等操作
    lazy var operatorBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = kBlueFontColor
        btn.titleLabel?.font = k12Font
        btn.setTitleColor(kWhiteColor, for: .normal)
        btn.setTitle("去结算", for: .normal)
        btn.cornerRadius = kCornerRadius
        btn.addTarget(self, action: #selector(clickedOperateBtn(btn:)), for: .touchUpInside)
        
        return btn
    }()
    /// 去结算、申请发货、确认收货等操作
    @objc func clickedOperateBtn(btn: UIButton){
        
    }
    /// 删除订单
    @objc func clickedDeleteBtn(){
        
    }
}
