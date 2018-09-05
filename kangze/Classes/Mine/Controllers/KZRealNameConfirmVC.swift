//
//  KZRealNameConfirmVC.swift
//  kangze
//  实名身份认证
//  Created by gouyz on 2018/9/5.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

class KZRealNameConfirmVC: GYZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "实名身份认证"
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
        
        contentView.addSubview(realNameView)
        contentView.addSubview(lineView)
        contentView.addSubview(idCardView)
        contentView.addSubview(lineView1)
        contentView.addSubview(des1Lab)
        contentView.addSubview(idCardImgView)
        contentView.addSubview(des2Lab)
        contentView.addSubview(idCardBgImgView)
        
        view.addSubview(okBtn)
        
        scrollView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.bottom.equalTo(okBtn.snp.top)
        }
        okBtn.snp.makeConstraints { (make) in
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
        
        realNameView.snp.makeConstraints { (make) in
            make.top.equalTo(kMargin)
            make.left.right.equalTo(view)
            make.height.equalTo(50)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(realNameView.snp.bottom)
            make.height.equalTo(klineWidth)
        }
        idCardView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom)
            make.left.right.height.equalTo(realNameView)
        }
        lineView1.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(lineView)
            make.bottom.equalTo(idCardView)
        }
        
        
        des1Lab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.top.equalTo(lineView1.snp.bottom)
            make.height.equalTo(kTitleHeight)
        }
        idCardImgView.snp.makeConstraints { (make) in
            make.left.right.equalTo(des1Lab)
            make.top.equalTo(des1Lab.snp.bottom).offset(kMargin)
            make.height.equalTo((kScreenWidth - kMargin * 2) * 0.56)
        }
        des2Lab.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(des1Lab)
            make.top.equalTo(idCardImgView.snp.bottom).offset(kMargin)
        }
        idCardBgImgView.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(idCardImgView)
            make.top.equalTo(des2Lab.snp.bottom).offset(kMargin)
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
    
    /// 真实姓名
    lazy var realNameView : GYZLabAndFieldView = {
        let lab = GYZLabAndFieldView.init(desName: "真实姓名：", placeHolder: "请填写真实姓名", isPhone: false)
        
        return lab
    }()
    /// 分割线
    fileprivate lazy var lineView : UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        return line
    }()
    /// 身份证号
    lazy var idCardView : GYZLabAndFieldView = {
        let lab = GYZLabAndFieldView.init(desName: "身份证号：", placeHolder: "请填写身份证号", isPhone: false)
        
        return lab
    }()
    /// 分割线
    fileprivate lazy var lineView1 : UIView = {
        let line = UIView()
        line.backgroundColor = kGrayLineColor
        return line
    }()
    var des1Lab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "1.上传身份证正面照片"
        
        return lab
    }()
    /// 身份证正面照片
    lazy var idCardImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.cornerRadius = kCornerRadius
        imgView.image = UIImage.init(named: "icon_add_img_big")
        
        return imgView
    }()
    
    var des2Lab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kBlackFontColor
        lab.text = "2.上传身份证反面照片"
        
        return lab
    }()
    /// 身份证反面照片
    lazy var idCardBgImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.cornerRadius = kCornerRadius
        imgView.image = UIImage.init(named: "icon_add_img_big")
        
        return imgView
    }()
    
    /// 确认上传
    fileprivate lazy var okBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = kBtnClickBGColor
        btn.setTitle("确认上传", for: .normal)
        btn.setTitleColor(kWhiteColor, for: .normal)
        btn.titleLabel?.font = k15Font
        
        btn.addTarget(self, action: #selector(clickedOkBtn), for: .touchUpInside)
        
        return btn
    }()
    
    
    /// 确认上传
    @objc func clickedOkBtn(){
        
    }
}
