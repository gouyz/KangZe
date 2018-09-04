//
//  KZMessageVC.swift
//  kangze
//  消息
//  Created by gouyz on 2018/9/3.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

class KZMessageVC: GYZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "消息"
        
        showEmptyView(content: "亲，暂时没有消息~", iconImgName: "icon_empty_msg", reload: nil)
        emptyView?.iconImgView.snp.updateConstraints({ (make) in
            make.height.equalTo(65)
            make.width.equalTo(136)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
