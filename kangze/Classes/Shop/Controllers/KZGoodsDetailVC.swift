//
//  KZGoodsDetailVC.swift
//  kangze
//  商品详情
//  Created by gouyz on 2018/8/29.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit
import WebKit

private let goodsDetailCell = "goodsDetailCell"


class KZGoodsDetailVC: GYZBaseVC {
    
    /// header 高度
    var headerViewH: CGFloat = kScreenWidth * 0.75 + 110 + kTitleHeight * 3

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationItem.title = "商品详情"
        navBarBgAlpha = 0
//        automaticallyAdjustsScrollViewInsets = false
        
        setLeftNavItem(imgName: "icon_back_white")
        
        view.addSubview(webView)
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(kBottomTabbarHeight)
        }
        
        headerView.productView.addOnClickListener(target: self, action: #selector(onClickedProductView))
        headerView.areasView.addOnClickListener(target: self, action: #selector(onClickedAreasView))
        
        webView.load(URLRequest.init(url: URL.init(string: "https://www.baidu.com/")!))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /// 设置返回键
    func setLeftNavItem(imgName: String){
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(clickedBackBtn))
    }
    
    lazy var headerView: KZGoodsDetailHeaderView = KZGoodsDetailHeaderView.init(frame: CGRect.init(x: 0, y: -headerViewH, width: kScreenWidth, height: headerViewH))
    
    /// 加载富文本 商品详情
    lazy var webView: WKWebView = {
        let webView = WKWebView.init(frame: CGRect.init(x: 0, y: -kTitleAndStateHeight, width: kScreenWidth, height: kScreenHeight + kTitleAndStateHeight - kBottomTabbarHeight))
        ///设置透明背景
        webView.backgroundColor = UIColor.white
        webView.isOpaque = false
        
        webView.scrollView.bouncesZoom = false
//        webView.scrollView.bounces = false
        webView.scrollView.alwaysBounceHorizontal = false
        
        webView.navigationDelegate = self
        
        webView.scrollView.contentInset = UIEdgeInsets.init(top: headerViewH, left: 0, bottom: 0, right: 0)
        webView.scrollView.delegate = self
        
        webView.scrollView.addSubview(headerView)
        
        return webView
    }()
    
    /// 底部View
    lazy var bottomView: KZGoodDetailBottomView = KZGoodDetailBottomView()
    
    /// 产品参数
    @objc func onClickedProductView(){
        let paramView = KZGoodsParamsView()
        paramView.show()
    }
    /// 我的区域
    @objc func onClickedAreasView(){
        
        let vc = KZSelectAreaVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension KZGoodsDetailVC : WKNavigationDelegate,UIScrollViewDelegate{
    ///MARK WKNavigationDelegate
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        /// 获取网页title
        //        self.title = self.webView.title
        //        self.hud?.hide(animated: true)
        
//        tableView.reloadData()
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        //        self.hud?.hide(animated: true)
    }
    
    //MARK:UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffsetY = scrollView.contentOffset.y
        let showNavBarOffsetY = -kScreenWidth * 0.75 - topLayoutGuide.length
        
        
        //navigationBar alpha
        if contentOffsetY > showNavBarOffsetY  {
            
            var navAlpha = (contentOffsetY - (showNavBarOffsetY)) / 40.0
            if navAlpha > 1 {
                navAlpha = 1
            }
            navBarBgAlpha = navAlpha
            self.navigationItem.title = "商品详情"
            setLeftNavItem(imgName: "icon_back")
        }else{
            navBarBgAlpha = 0
            self.navigationItem.title = ""
            setLeftNavItem(imgName: "icon_back_white")
        }
    }
}

