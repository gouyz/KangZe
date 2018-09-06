//
//  KZRechargeVC.swift
//  kangze
//  充值中心
//  Created by gouyz on 2018/9/6.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

class KZRechargeVC: GYZBaseVC {
    
    ///修改价格时输入是否有小数点
    var isHaveDian: Bool = false
    ///修改价格时输入第一位是否是0
    var isFirstZero: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "充值中心"
        
        view.addSubview(bgView)
        bgView.addSubview(desLab)
        bgView.addSubview(unitLab)
        bgView.addSubview(moneyField)
        bgView.addSubview(lineView)
        bgView.addSubview(nextBtn)
        bgView.addSubview(recordLab)
        
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(20 + kTitleAndStateHeight)
            make.height.equalTo(300)
        }
        
        desLab.snp.makeConstraints { (make) in
            make.top.equalTo(kTitleHeight)
            make.left.equalTo(kMargin)
            make.height.equalTo(30)
            make.right.equalTo(-kMargin)
        }
        unitLab.snp.makeConstraints { (make) in
            make.left.equalTo(desLab)
            make.top.equalTo(desLab.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.width.equalTo(30)
        }
        moneyField.snp.makeConstraints { (make) in
            make.left.equalTo(unitLab.snp.right)
            make.right.equalTo(-kMargin)
            make.top.height.equalTo(unitLab)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(moneyField)
            make.top.equalTo(moneyField.snp.bottom)
            make.height.equalTo(klineWidth)
        }
        
        nextBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(desLab)
            make.top.equalTo(unitLab.snp.bottom).offset(kTitleHeight)
            make.height.equalTo(kUIButtonHeight)
        }
        recordLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgView)
            make.top.equalTo(nextBtn.snp.bottom).offset(kMargin)
            make.size.equalTo(CGSize.init(width: 80, height: 30))
        }
        
        moneyField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = kWhiteColor
        
        return view
    }()
    ///
    lazy var desLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "充值金额"
        
        return lab
    }()
    lazy var unitLab : UILabel = {
        let lab = UILabel()
        lab.font = UIFont.boldSystemFont(ofSize: 20)
        lab.textColor = kBlackFontColor
        lab.textAlignment = .center
        lab.text = "￥"
        
        return lab
    }()
    /// 输入内容
    lazy var moneyField : UITextField = {
        
        let textFiled = UITextField()
        textFiled.font = k18Font
        textFiled.textColor = kBlackFontColor
        textFiled.placeholder = "请输入金额"
        textFiled.keyboardType = .decimalPad
        textFiled.clearButtonMode = .whileEditing
        
        return textFiled
    }()
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = kGrayLineColor
        
        return view
    }()
    /// 下一步
    lazy var nextBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = kBtnClickBGColor
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kWhiteColor, for: .normal)
        btn.setTitle("下一步", for: .normal)
        btn.cornerRadius = kCornerRadius
        btn.addTarget(self, action: #selector(clickedNextBtn), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var recordLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlueFontColor
        lab.textAlignment = .center
        lab.text = "充值记录"
        lab.addOnClickListener(target: self, action: #selector(onClickedRecord))
        
        return lab
    }()
    /// 下一步
    @objc func clickedNextBtn(){
        showPayView()
    }
    
    func showPayView(){
        let payView = KZSelectPayMethodView()
        payView.yuEView.isHidden = true
        payView.lineView.isHidden = true
        payView.yuEView.snp.updateConstraints { (make) in
            make.height.equalTo(0)
        }
        payView.selectPayTypeBlock = { [weak self](index) in
            
            payView.hide()
            self?.dealPay(index: index)
        }
        payView.show()
    }
    /// 支付
    func dealPay(index: Int){
        
        let vc = KZPosPayVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    ///充值记录
    @objc func onClickedRecord(){
        let vc = KZRechargeRecordVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension KZRechargeVC: UITextFieldDelegate{
    ////  MARK: UITextFieldDelegate
    //1.要求用户输入首位不能为小数点;
    //2.小数点后不超过两位，小数点无法输入超过一个;
    //3.如果首位为0，后面仅能输入小数点
    //MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        if ((textField.text?.range(of: ".")) == nil) {//是否输入点.
            isHaveDian = false
        }
        if ((textField.text?.range(of: "0")) == nil) {//首位是否输入0.
            isFirstZero = false
        }
        
        if string.count > 0 {
            //当前输入的字符
            let single = string[string.startIndex]
            //数据格式正确
            if (single >= "0" && single <= "9") || single == "." {
                if textField.text?.count == 0 {
                    //首字母不能为小数点
                    if single == "." {
                        return false
                    }else if single == "0" {
                        isFirstZero = true
                        return true
                    }
                }else{
                    if single == "." {
                        if isHaveDian {//不允许输入多个小数点
                            return false
                        } else {//text中还没有小数点
                            isHaveDian = true
                            return true
                        }
                    }else if single == "0" {
                        //首位有0有.（0.01）或首位没0有.（10200.00）可输入两位数的0
                        if (isHaveDian && isFirstZero) || (!isFirstZero && isHaveDian) {
                            
                            if textField.text == "0.0" {
                                return false
                            }
                            let ran = textField.text?.nsRange(from: (textField.text?.range(of: "."))!)
                            let tt = range.location - (ran?.location)!
                            //判断小数点后的位数,只允许输入2位
                            if tt <= 2 {
                                return true
                            }else{
                                return false
                            }
                        } else if isFirstZero && !isHaveDian{
                            //首位有0没.不能再输入0
                            return false
                        }else{
                            ///整数部分不能超过8位，与数据库匹配
                            if textField.text?.count > 7 {
                                return false
                            }
                            return true
                        }
                    }else{
                        if isHaveDian {//存在小数点，保留两位小数
                            let ran = textField.text?.nsRange(from: (textField.text?.range(of: "."))!)
                            let tt = range.location - (ran?.location)!
                            //判断小数点后的位数,只允许输入2位
                            if tt <= 2 {
                                return true
                            }else{
                                return false
                            }
                        } else if isFirstZero && !isHaveDian{
                            //首位有0没.不能再输入0
                            return false
                        }else{
                            ///整数部分不能超过8位，与数据库匹配
                            if textField.text?.count > 7 {
                                return false
                            }
                            return true
                        }
                    }
                }
            }else{
                //输入的数据格式不正确
                return false
            }
        }else{
            return true
        }
        return true
    }
}
