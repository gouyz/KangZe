//
//  KZSelectAreaVC.swift
//  kangze
//  区域选择
//  Created by gouyz on 2018/9/7.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

class KZSelectAreaVC: GYZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "区域选择"
        self.view.backgroundColor = kWhiteColor
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI(){
        
        view.addSubview(desLab)
        view.addSubview(provinceView)
        provinceView.addSubview(provinceLab)
        provinceView.addSubview(arrowImgView1)
        
        view.addSubview(cityView)
        cityView.addSubview(cityLab)
        cityView.addSubview(arrowImgView2)
        
        view.addSubview(areaView)
        areaView.addSubview(areaLab)
        areaView.addSubview(arrowImgView3)
        
        view.addSubview(saveBtn)
        
        desLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.top.equalTo(kMargin + kTitleAndStateHeight)
            make.right.equalTo(-kMargin)
            make.height.equalTo(kTitleHeight)
        }
        
        provinceView.snp.makeConstraints { (make) in
            make.top.equalTo(desLab.snp.bottom).offset(kMargin)
            make.left.equalTo(desLab)
            make.height.equalTo(30)
            make.width.equalTo(cityView)
        }
        cityView.snp.makeConstraints { (make) in
            make.top.height.equalTo(provinceView)
            make.left.equalTo(provinceView.snp.right).offset(30)
            make.width.equalTo(areaView)
        }
        areaView.snp.makeConstraints { (make) in
            make.top.height.width.equalTo(provinceView)
            make.left.equalTo(cityView.snp.right).offset(30)
            make.right.equalTo(-kMargin)
        }
        
        provinceLab.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.right.equalTo(arrowImgView1.snp.left).offset(-5)
            make.top.bottom.equalTo(provinceView)
        }
        arrowImgView1.snp.makeConstraints { (make) in
            make.right.equalTo(-5)
            make.centerY.equalTo(provinceView)
            make.size.equalTo(CGSize.init(width: 7, height: 4))
        }
        cityLab.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.right.equalTo(arrowImgView2.snp.left).offset(-5)
            make.top.bottom.equalTo(cityView)
        }
        arrowImgView2.snp.makeConstraints { (make) in
            make.right.equalTo(-5)
            make.centerY.equalTo(cityView)
            make.size.equalTo(CGSize.init(width: 7, height: 4))
        }
        areaLab.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.right.equalTo(arrowImgView3.snp.left).offset(-5)
            make.top.bottom.equalTo(areaView)
        }
        arrowImgView3.snp.makeConstraints { (make) in
            make.right.equalTo(-5)
            make.centerY.equalTo(areaView)
            make.size.equalTo(CGSize.init(width: 7, height: 4))
        }
        
        saveBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(view)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(kUIButtonHeight)
        }
    }
    
    ///
    lazy var desLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "选择我的区域"
        
        return lab
    }()

    lazy var provinceView: UIView = {
        let view = UIView()
        view.backgroundColor = kBackgroundColor
        view.cornerRadius = kCornerRadius
        view.tag = 101
        view.addOnClickListener(target: self, action: #selector(onClickedSelect(sender:)))
        
        return view
    }()
    /// 省
    lazy var provinceLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kBlackFontColor
        lab.textAlignment = .center
        lab.text = "江苏省"
        
        return lab
    }()
    lazy var arrowImgView1: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_arrow_down"))
    
    lazy var areaView: UIView = {
        let view = UIView()
        view.backgroundColor = kBackgroundColor
        view.cornerRadius = kCornerRadius
        view.tag = 103
        view.addOnClickListener(target: self, action: #selector(onClickedSelect(sender:)))
        
        return view
    }()
    /// 区
    lazy var areaLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kBlackFontColor
        lab.textAlignment = .center
        lab.text = "新北区"
        
        return lab
    }()
    lazy var arrowImgView3: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_arrow_down"))
    
    lazy var cityView: UIView = {
        let view = UIView()
        view.backgroundColor = kBackgroundColor
        view.cornerRadius = kCornerRadius
        view.tag = 102
        view.addOnClickListener(target: self, action: #selector(onClickedSelect(sender:)))
        
        return view
    }()
    /// 市
    lazy var cityLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kBlackFontColor
        lab.textAlignment = .center
        lab.text = "常州市"
        
        return lab
    }()
    lazy var arrowImgView2: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_arrow_down"))
    
    /// 确认
    lazy var saveBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = kBtnClickBGColor
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kWhiteColor, for: .normal)
        btn.cornerRadius = kCornerRadius
        btn.setTitle("确认", for: .normal)
        btn.addTarget(self, action: #selector(clickedSaveBtn), for: .touchUpInside)
        
        return btn
    }()
    /// 确认
    @objc func clickedSaveBtn(){
        
    }
    
    /// 选择省市区
    @objc func onClickedSelect(sender: UITapGestureRecognizer){
        
        let selectView = KZSelectAreaView()
        selectView.show()
    }
}
