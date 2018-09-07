//
//  KZCustomerInfoVC.swift
//  kangze
//  客户管理
//  Created by gouyz on 2018/9/7.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

class KZCustomerInfoVC: GYZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = kWhiteColor
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupUI(){
        view.addSubview(desLab)
        view.addSubview(saleLab)
        view.addSubview(saleNumberLab)
        view.addSubview(daiLiLab)
        view.addSubview(daiLiNumberLab)
        
        desLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.top.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.height.equalTo(kTitleHeight)
        }
        saleLab.snp.makeConstraints { (make) in
            make.left.equalTo(desLab)
            make.top.equalTo(desLab.snp.bottom).offset(kMargin)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        saleNumberLab.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(saleLab)
            make.top.equalTo(saleLab.snp.bottom)
        }
        daiLiLab.snp.makeConstraints { (make) in
            make.left.equalTo(saleLab.snp.right).offset(kMargin)
            make.top.height.width.equalTo(saleLab)
        }
        daiLiNumberLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(daiLiLab)
            make.height.top.equalTo(saleNumberLab)
        }
    }
    
    ///
    lazy var desLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "概述"
        
        return lab
    }()
    /// 零售人数
    lazy var saleLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kBlueFontColor
        lab.textAlignment = .center
        lab.text = "零售人数"
        
        return lab
    }()
    /// 零售人数
    lazy var saleNumberLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kBlackFontColor
        lab.textAlignment = .center
        lab.text = "7788"
        
        return lab
    }()
    /// 代理人数
    lazy var daiLiLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kBlueFontColor
        lab.textAlignment = .center
        lab.text = "代理人数"
        
        return lab
    }()
    /// 代理人数
    lazy var daiLiNumberLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kBlackFontColor
        lab.textAlignment = .center
        lab.text = "788"
        
        return lab
    }()
}
