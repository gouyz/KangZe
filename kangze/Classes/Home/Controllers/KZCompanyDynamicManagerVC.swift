//
//  KZCompanyDynamicManagerVC.swift
//  kangze
//  公司动态
//  Created by gouyz on 2018/8/31.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

class KZCompanyDynamicManagerVC: GYZBaseVC {
    
    let titleArr : [String] = ["公司动态","公司介绍","精选文章"]
    var scrollPageView: ScrollPageView?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "公司动态"
        
        view.addSubview(bannerImgView)
        
        setScrollView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    ///设置控制器
    func setChildVcs() -> [GYZBaseVC] {
        
        let dynamicVC = KZCompanyDynamicVC()
        
        let introduceVC = KZCompanyIntroduceVC()
        
        let articleVC = KZCompanyArticlesVC()
        
        return [dynamicVC,introduceVC,articleVC]
    }
    
    /// 设置scrollView
    func setScrollView(){
        // 这个是必要的设置
        automaticallyAdjustsScrollViewInsets = false
        
        var style = SegmentStyle()
        // 滚动条
        style.showLine = true
        style.scrollTitle = false
        // 颜色渐变
        style.gradualChangeTitleColor = true
        // 滚动条颜色
        style.scrollLineColor = kWhiteColor
        style.normalTitleColor = kBlackFontColor
        style.selectedTitleColor = kBlueFontColor
        /// 显示角标
        style.showBadge = false
        
        scrollPageView = ScrollPageView.init(frame: CGRect.init(x: 0, y: bannerImgView.bottomY, width: kScreenWidth, height: self.view.frame.height - bannerImgView.bottomY), segmentStyle: style, titles: titleArr, childVcs: setChildVcs(), parentViewController: self)
        view.addSubview(scrollPageView!)
    }
    /// banner图
    lazy var bannerImgView: UIImageView = {
        
        let imgView = UIImageView.init(frame: CGRect.init(x: 0, y: kTitleAndStateHeight, width: kScreenWidth, height: kScreenWidth * 0.28))
        imgView.image = UIImage.init(named: "icon_company_banner")
        
        return imgView
    }()
}
