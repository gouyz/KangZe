//
//  KZAboutVC.swift
//  kangze
//  关于我们
//  Created by gouyz on 2018/9/5.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

class KZAboutVC: GYZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "关于我们"
        self.view.backgroundColor = kWhiteColor
        
        
        view.addSubview(logoImgView)
        view.addSubview(nameLab)
        view.addSubview(versionLab)
        view.addSubview(checkVersionLab)
        
        logoImgView.snp.makeConstraints { (make) in
            make.top.equalTo(kTitleAndStateHeight * 2)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize.init(width: 90, height: 90))
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.right.equalTo(-kMargin)
            make.height.equalTo(kTitleHeight)
            make.top.equalTo(logoImgView.snp.bottom)
        }
        versionLab.snp.makeConstraints { (make) in
            make.top.equalTo(nameLab.snp.bottom).offset(kTitleAndStateHeight)
            make.left.right.height.equalTo(nameLab)
        }
        checkVersionLab.snp.makeConstraints { (make) in
            make.top.equalTo(versionLab.snp.bottom)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize.init(width: 100, height: 34))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var logoImgView: UIImageView = UIImageView.init(image: UIImage.init(named: "icon_logo"))
    
    ///
    lazy var nameLab : UILabel = {
        let lab = UILabel()
        lab.font = UIFont.boldSystemFont(ofSize: 18)
        lab.textColor = kBlackFontColor
        lab.textAlignment = .center
        lab.text = "康立维"
        
        return lab
    }()
    lazy var versionLab : UILabel = {
        let lab = UILabel()
        lab.font = k15Font
        lab.textColor = kGaryFontColor
        lab.textAlignment = .center
        lab.text = "版本号：V"  +  GYZUpdateVersionTool.getCurrVersion()
        
        return lab
    }()
    
    lazy var checkVersionLab : UILabel = {
        let lab = UILabel()
        lab.font = k13Font
        lab.textColor = kBlackFontColor
        lab.textAlignment = .center
        lab.borderColor = kBlackFontColor
        lab.borderWidth = klineWidth
        lab.cornerRadius = kCornerRadius
        lab.text = "检测到最新版本"
        
        return lab
    }()
}