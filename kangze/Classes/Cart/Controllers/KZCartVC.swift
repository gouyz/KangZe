//
//  KZCartVC.swift
//  kangze
//  购物车
//  Created by gouyz on 2018/8/28.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

private let cartCell = "cartCell"

class KZCartVC: GYZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "购物车"
        
        view.addSubview(tableView)
        view.addSubview(bottomView)
        
        bottomView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)

            make.bottom.equalTo(-kTabBarHeight)
            make.height.equalTo(kTitleHeight)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(bottomView.snp.top)
            }else{
                make.bottom.equalTo(-kTitleHeight)
            }
        }
        
        let total: String = "合计：￥998"
        let totalAttr : NSMutableAttributedString = NSMutableAttributedString(string: total)
        totalAttr.addAttribute(NSAttributedStringKey.foregroundColor, value: kBlackFontColor, range: NSMakeRange(0, 3))
        bottomView.totalLab.attributedText = totalAttr
        
        bottomView.jieSuanLab.text = "结算(3)"
        bottomView.jieSuanLab.addOnClickListener(target: self, action: #selector(onClickedJieSuan))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.separatorColor = kGrayLineColor
        
        table.register(KZCartCell.self, forCellReuseIdentifier: cartCell)
        //        weak var weakSelf = self
        //        ///添加下拉刷新
        //        GYZTool.addPullRefresh(scorllView: table, pullRefreshCallBack: {
        //            weakSelf?.refresh()
        //        })
        //        ///添加上拉加载更多
        //        GYZTool.addLoadMore(scorllView: table, loadMoreCallBack: {
        //            weakSelf?.loadMore()
        //        })
        
        return table
    }()
    /// 底部View
    lazy var bottomView: KZCartBottomView = KZCartBottomView()
    
    /// 结算
    @objc func onClickedJieSuan(){
        let vc = KZSubmitOrderVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension KZCartVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cartCell) as! KZCartCell
        
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
}
