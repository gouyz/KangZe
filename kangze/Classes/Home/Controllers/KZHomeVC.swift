//
//  KZHomeVC.swift
//  kangze
//  首页
//  Created by gouyz on 2018/8/28.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

private let homeCell = "homeCell"

class KZHomeVC: KZCommonNavBarVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        tableView.tableHeaderView = headerView
        
        headerView.operatorBlock = {[weak self] (tag) in
            self?.dealOperator(index: tag)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        
        table.register(KZHomeCell.self, forCellReuseIdentifier: homeCell)
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
    
    lazy var headerView: KZHomeAdsHeaderView = KZHomeAdsHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: (kScreenWidth - kMargin * 2) * 0.4 + 80))
    
    /// 公司动态、订单、朋友圈素材、消息
    func dealOperator(index : Int){
        switch index {
        case 1://公司动态
            goDynamic()
        case 2://订单
            break
        case 3://朋友圈素材
            break
        case 4://消息
            break
        default:
            break
        }
    }
    ///公司动态
    func goDynamic(){
        let vc = KZCompanyDynamicManagerVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension KZHomeVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCell) as! KZHomeCell
        
        if indexPath.row == 0 {
            cell.iconView.image = UIImage.init(named: "icon_home_hot_sale")
            cell.nameLab.text = "本周热销"
            cell.adsImgView.image = UIImage.init(named: "icon_home_hot_sale_banner")
        }else if indexPath.row == 1 {
            cell.iconView.image = UIImage.init(named: "icon_home_hehuo")
            cell.nameLab.text = "合伙人套餐"
            cell.adsImgView.image = UIImage.init(named: "icon_home_hehuo_banner")
        }else{
            cell.iconView.image = UIImage.init(named: "icon_home_xuhuo")
            cell.nameLab.text = "续货套餐"
            cell.adsImgView.image = UIImage.init(named: "icon_home_xuhuo_banner")
        }
        
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
        return (kScreenWidth - kMargin * 2) * 0.5 + 70
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
}
