//
//  KZConfirmHeHuoRenVC.swift
//  kangze
//  合伙人认证
//  Created by gouyz on 2018/9/5.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

class KZConfirmHeHuoRenVC: GYZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "合伙人认证"
        self.view.backgroundColor = kWhiteColor
        
        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI(){
        view.addSubview(bgView)
        bgView.addSubview(realNameLab)
        bgView.addSubview(nameStatusLab)
        bgView.addSubview(rightIconView1)
        view.addSubview(lineView1)
        
        view.addSubview(personView)
        personView.addSubview(heHuoPersonLab)
        personView.addSubview(buyStatusLab)
        personView.addSubview(rightIconView2)
        view.addSubview(lineView2)
        
        bgView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(kTitleAndStateHeight)
            make.height.equalTo(50)
        }
        realNameLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(nameStatusLab.snp.left).offset(-kMargin)
            make.top.bottom.equalTo(bgView)
        }
        nameStatusLab.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(realNameLab)
            make.right.equalTo(rightIconView1.snp.left).offset(-kMargin)
            make.width.equalTo(60)
        }
        rightIconView1.snp.makeConstraints { (make) in
            make.centerY.equalTo(realNameLab)
            make.right.equalTo(-kMargin)
            make.size.equalTo(CGSize.init(width: 7, height: 12))
        }
        lineView1.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(bgView.snp.bottom)
            make.height.equalTo(klineWidth)
        }
        
        personView.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(bgView)
            make.top.equalTo(lineView1.snp.bottom)
        }
        heHuoPersonLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(buyStatusLab.snp.left).offset(-kMargin)
            make.top.bottom.equalTo(personView)
        }
        buyStatusLab.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(heHuoPersonLab)
            make.right.equalTo(rightIconView2.snp.left).offset(-kMargin)
            make.width.equalTo(nameStatusLab)
        }
        rightIconView2.snp.makeConstraints { (make) in
            make.centerY.equalTo(heHuoPersonLab)
            make.right.size.equalTo(rightIconView1)
        }
        lineView2.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(lineView1)
            make.top.equalTo(personView.snp.bottom)
        }
    }

    ///
    lazy var bgView : UIView = {
        let view = UIView()
        view.addOnClickListener(target: self, action: #selector(onClickedRealNameConfirm))
        
        return view
    }()
    /// 实名身份认证
    lazy var realNameLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "实名身份认证"
        
        return lab
    }()
    
    /// 实名身份认证 状态
    var nameStatusLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kGaryFontColor
        lab.textAlignment = .right
        lab.text = "未完成"
        
        return lab
    }()
    /// 右侧箭头图标
    lazy var rightIconView1: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_right_arrow"))
    
    /// 分割线
    var lineView1 : UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        return line
    }()
    
    ///
    lazy var personView : UIView = {
        let view = UIView()
        view.addOnClickListener(target: self, action: #selector(onClickedHeHuoRenConfirm))
        
        return view
    }()
    /// 合伙人套餐购买认证
    lazy var heHuoPersonLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "合伙人套餐购买认证"
        
        return lab
    }()
    
    /// 合伙人套餐购买认证 状态
    var buyStatusLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kGaryFontColor
        lab.textAlignment = .right
        lab.text = "未完成"
        
        return lab
    }()
    /// 右侧箭头图标
    lazy var rightIconView2: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_right_arrow"))
    
    /// 分割线
    var lineView2 : UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        return line
    }()
    ///实名身份认证
    @objc func onClickedRealNameConfirm(){
        
        let vc = KZRealNameConfirmVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    ///合伙人套餐购买认证
    @objc func onClickedHeHuoRenConfirm(){
        let vc = KZGoodsDetailVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
