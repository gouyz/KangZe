//
//  KZEditAddressVC.swift
//  kangze
//  编辑、新增地址
//  Created by gouyz on 2018/9/5.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

class KZEditAddressVC: GYZBaseVC {
    
    /// 是否新增地址
    var isAdd: Bool = false
    /// 性别 0男 1女
    var sex: String = "0"

    override func viewDidLoad() {
        super.viewDidLoad()

        if isAdd {
            self.navigationItem.title = "新增地址"
        }else{
            self.navigationItem.title = "编辑地址"
        }
        
        self.view.backgroundColor = kWhiteColor
        setUpUI()
        
        manCheckBtn.isSelected = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUI(){
        
        view.addSubview(nameView)
        view.addSubview(lineView)
        view.addSubview(manCheckBtn)
        view.addSubview(womanCheckBtn)
        view.addSubview(lineView1)
        view.addSubview(phoneView)
        view.addSubview(lineView2)
        view.addSubview(addressView)
        view.addSubview(lineView3)
        
        view.addSubview(submitBtn)
        
        nameView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.height.equalTo(50)
            make.top.equalTo(kMargin + kTitleAndStateHeight)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.top.equalTo(nameView.snp.bottom)
            make.height.equalTo(klineWidth)
        }
        manCheckBtn.snp.makeConstraints { (make) in
            make.right.equalTo(nameView.snp.centerX).offset(-kMargin)
            make.top.equalTo(lineView.snp.bottom)
            make.width.equalTo(60)
            make.height.equalTo(nameView)
        }
        womanCheckBtn.snp.makeConstraints { (make) in
            make.left.equalTo(nameView.snp.centerX).offset(kMargin)
            make.top.size.equalTo(manCheckBtn)
        }
        lineView1.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(lineView)
            make.top.equalTo(manCheckBtn.snp.bottom)
        }
        phoneView.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(nameView)
            make.top.equalTo(lineView1.snp.bottom)
        }
        lineView2.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(lineView)
            make.top.equalTo(phoneView.snp.bottom)
        }
        addressView.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(nameView)
            make.top.equalTo(lineView2.snp.bottom)
        }
        lineView3.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(lineView)
            make.top.equalTo(addressView.snp.bottom)
        }
        submitBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(kBottomTabbarHeight)
            make.top.equalTo(lineView3.snp.bottom).offset(80)
        }
    }
    /// 联系人
    lazy var nameView : GYZLabAndFieldView = {
        let lab = GYZLabAndFieldView.init(desName: "联系人：", placeHolder: "请填写收货人的姓名", isPhone: false)
        
        return lab
    }()
    /// 线
    lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        
        return line
    }()
    /// 先生
    lazy var manCheckBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kBlackFontColor, for: .normal)
        btn.setTitle("先生", for: .normal)
        btn.setImage(UIImage.init(named: "icon_check"), for: .normal)
        btn.setImage(UIImage.init(named: "icon_check_selected"), for: .selected)
        btn.addTarget(self, action: #selector(radioBtnChecked(btn:)), for: .touchUpInside)
        btn.tag = 101
        
        return btn
    }()
    
    /// 女士
    lazy var womanCheckBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kBlackFontColor, for: .normal)
        btn.setTitle("女士", for: .normal)
        btn.setImage(UIImage.init(named: "icon_check"), for: .normal)
        btn.setImage(UIImage.init(named: "icon_check_selected"), for: .selected)
        btn.addTarget(self, action: #selector(radioBtnChecked(btn:)), for: .touchUpInside)
        btn.tag = 102
        
        return btn
    }()
    /// 线
    lazy var lineView1: UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        
        return line
    }()
    /// 手机号
    lazy var phoneView : GYZLabAndFieldView = {
        let lab = GYZLabAndFieldView.init(desName: "手机号：", placeHolder: "请填写收货人手机号", isPhone: true)
        
        return lab
    }()
    /// 线
    lazy var lineView2: UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        
        return line
    }()
    /// 收货地址
    lazy var addressView : GYZLabAndFieldView = {
        let lab = GYZLabAndFieldView.init(desName: "收货地址：", placeHolder: "请填写收货地址", isPhone: false)
        
        return lab
    }()
    /// 线
    lazy var lineView3: UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        
        return line
    }()
    
    /// 完成
    lazy var submitBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = kBtnClickBGColor
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kWhiteColor, for: .normal)
        btn.setTitle("完 成", for: .normal)
        btn.addTarget(self, action: #selector(clickedSubmitBtn), for: .touchUpInside)
        
        return btn
    }()
    /// 完成
    @objc func clickedSubmitBtn(){
        
    }
    
    /// 选择先生/女士
    ///
    /// - Parameter btn:
    @objc func radioBtnChecked(btn: UIButton){
        let tag = btn.tag
        
        btn.isSelected = !btn.isSelected
        
        if tag == 101 {/// 先生
            sex = "0"
            womanCheckBtn.isSelected = false
        } else {/// 女士
            sex = "1"
            manCheckBtn.isSelected = false
        }
    }
}
