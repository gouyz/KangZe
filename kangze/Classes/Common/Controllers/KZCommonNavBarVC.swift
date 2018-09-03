//
//  KZCommonNavBarVC.swift
//  kangze
//  首页和商城 NavBar View
//  Created by gouyz on 2018/8/28.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

class KZCommonNavBarVC: GYZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = navBarView
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = k10Font
        btn.setTitleColor(kBlackFontColor, for: .normal)
        btn.frame = CGRect.init(x: 0, y: 0, width: kTitleHeight, height: kTitleHeight)
        btn.addTarget(self, action: #selector(onClickedQrcode), for: .touchUpInside)
        btn.set(image: UIImage.init(named: "icon_qrcode"), title: "邀请码", titlePosition: .bottom, additionalSpacing: 1, state: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /// 邀请码
    @objc func onClickedQrcode(){
        
    }
    
    lazy var navBarView: GYZSearchNavBarView = GYZSearchNavBarView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kTitleHeight))
}
