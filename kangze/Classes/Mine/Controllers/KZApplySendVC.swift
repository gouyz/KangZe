//
//  KZApplySendVC.swift
//  kangze
//  申请发货
//  Created by gouyz on 2018/9/5.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

class KZApplySendVC: GYZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "申请发货"
        self.view.backgroundColor = kWhiteColor
        
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 创建UI
    fileprivate func setupUI(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(personLab)
        contentView.addSubview(lineView)
        contentView.addSubview(phoneLab)
        bgView.addSubview(lineView1)
        contentView.addSubview(bgView)
        bgView.addSubview(addressLab)
        bgView.addSubview(rightIconView)
        contentView.addSubview(lineView2)
        contentView.addSubview(iconView)
        contentView.addSubview(nameLab)
        contentView.addSubview(kuCunLab)
        contentView.addSubview(minusIconView)
        contentView.addSubview(countLab)
        contentView.addSubview(addIconView)
        contentView.addSubview(lineView3)
        contentView.addSubview(moneyLab)
        
        view.addSubview(submitBtn)
        
        scrollView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.bottom.equalTo(submitBtn.snp.top)
        }
        submitBtn.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(kBottomTabbarHeight)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.left.width.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
            // 这个很重要！！！！！！
            // 必须要比scroll的高度大一，这样才能在scroll没有填充满的时候，保持可以拖动
            make.height.greaterThanOrEqualTo(scrollView).offset(1)
        }
        
        personLab.snp.makeConstraints { (make) in
            make.top.equalTo(contentView)
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.height.equalTo(50)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView)
            make.top.equalTo(personLab.snp.bottom)
            make.height.equalTo(klineWidth)
        }
        phoneLab.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(personLab)
            make.top.equalTo(lineView.snp.bottom)
        }
        lineView1.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(lineView)
            make.top.equalTo(phoneLab.snp.bottom)
        }
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1.snp.bottom)
            make.left.right.equalTo(contentView)
            make.height.equalTo(personLab)
        }
        addressLab.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(bgView)
            make.left.equalTo(kMargin)
            make.right.equalTo(rightIconView.snp.left).offset(-kMargin)
        }
        rightIconView.snp.makeConstraints { (make) in
            make.centerY.equalTo(bgView)
            make.right.equalTo(-kMargin)
            make.size.equalTo(CGSize.init(width: 7, height: 12))
        }
        lineView2.snp.makeConstraints { (make) in
            make.left.height.right.equalTo(lineView)
            make.top.equalTo(bgView.snp.bottom)
        }
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView2.snp.bottom).offset(kMargin)
            make.left.equalTo(personLab)
            make.size.equalTo(CGSize.init(width: 90, height: 90))
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(kMargin)
            make.top.equalTo(iconView)
            make.right.equalTo(-kMargin)
            make.bottom.equalTo(kuCunLab.snp.top)
        }
        kuCunLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLab)
            make.height.equalTo(20)
            make.bottom.equalTo(addIconView.snp.top)
        }
        addIconView.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconView)
            make.right.equalTo(-kMargin)
            make.size.equalTo(CGSize.init(width: 20, height: 20))
        }
        countLab.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(addIconView)
            make.right.equalTo(addIconView.snp.left)
            make.width.equalTo(30)
        }
        minusIconView.snp.makeConstraints { (make) in
            make.centerY.size.equalTo(addIconView)
            make.right.equalTo(countLab.snp.left)
        }
        lineView3.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(lineView)
            make.top.equalTo(iconView.snp.bottom).offset(kMargin)
        }
        moneyLab.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(personLab)
            make.top.equalTo(lineView3.snp.bottom)
            // 这个很重要，viewContainer中的最后一个控件一定要约束到bottom，并且要小于等于viewContainer的bottom
            // 否则的话，上面的控件会被强制拉伸变形
            // 最后的-10是边距，这个可以随意设置
            make.bottom.lessThanOrEqualTo(contentView).offset(-kMargin)
        }
    }
    
    /// scrollView
    var scrollView: UIScrollView = UIScrollView()
    /// 内容View
    var contentView: UIView = UIView()
    
    /// 收件人
    lazy var personLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "收件人：张女士"
        
        return lab
    }()
    lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        
        return line
    }()
    /// 电话
    lazy var phoneLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "电话：13323467899"
        
        return lab
    }()
    lazy var lineView1: UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        
        return line
    }()
    lazy var bgView: UIView = {
        let view = UIView()
        view.addOnClickListener(target: self, action: #selector(onClickedSelectAddress))
        
        return view
    }()
    /// 地址
    lazy var addressLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.numberOfLines = 2
        lab.text = "地址：常州市新北区常州市新北区常州市新北区"
        
        return lab
    }()
    
    /// 右侧箭头图标
    lazy var rightIconView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_right_arrow"))
    
    /// 分割线
    var lineView2 : UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        return line
    }()
    /// 商品图标
    lazy var iconView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_shop_default"))
    
    /// 商品名称
    lazy var nameLab : UILabel = {
        let lab = UILabel()
        lab.font = k12Font
        lab.textColor = kBlackFontColor
        lab.numberOfLines = 2
        lab.text = "澳洲原装天然海藻油DHA帮助大脑发育增强记忆降低血糖全球妈妈的首选"
        
        return lab
    }()
    /// 库存
    lazy var kuCunLab : UILabel = {
        let lab = UILabel()
        lab.font = k12Font
        lab.textColor = kBlackFontColor
        lab.text = "现有库存：6"
        
        return lab
    }()
    /// 加
    lazy var addIconView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_add"))
    
    /// 数量
    lazy var countLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "1"
        lab.textAlignment = .center
        
        return lab
    }()
    
    /// 减
    lazy var minusIconView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_minus"))
    /// 分割线
    var lineView3 : UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        return line
    }()
    
    /// 运费
    lazy var moneyLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kRedFontColor
        lab.textAlignment = .right
        lab.text = "运费：￥6.00"
        
        return lab
    }()
    
    /// 提交申请
    lazy var submitBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = kBtnClickBGColor
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kWhiteColor, for: .normal)
        btn.setTitle("提交申请", for: .normal)
        btn.addTarget(self, action: #selector(clickedSubmitBtn), for: .touchUpInside)
        
        return btn
    }()
    /// 提交申请
    @objc func clickedSubmitBtn(){
        showPayView()
    }
    /// 选择地址
    @objc func onClickedSelectAddress(){
    
        let vc = KZMyAddressVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showPayView(){
        let payView = KZSelectPayMethodView()
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
}
