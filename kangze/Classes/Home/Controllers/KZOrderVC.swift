//
//  KZOrderVC.swift
//  kangze
//  我的订单
//  Created by gouyz on 2018/9/3.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit
import MBProgressHUD

private let orderCell = "orderCell"
private let orderHeader = "orderHeader"
private let orderFooter = "orderFooter"

class KZOrderVC: GYZBaseVC {
    
    var orderStatus: String = ""
//    var currPage : Int = 1
    var dataList: [KZOrderModel] = [KZOrderModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            
            make.edges.equalTo(0)
        }
        requestOrderDatas()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// 懒加载UITableView
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        
        table.register(KZOrderCell.self, forCellReuseIdentifier: orderCell)
        table.register(KZOrderHeaderView.self, forHeaderFooterViewReuseIdentifier: orderHeader)
        table.register(KZOrderFooterView.self, forHeaderFooterViewReuseIdentifier: orderFooter)
//
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
    
    ///获取数据
    func requestOrderDatas(){
        
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        showLoadingView()
        
        GYZNetWork.requestNetwork("member_order&op=order_list",parameters: [/*"curpage":currPage,"page":kPageSize,*/"key": userDefaults.string(forKey: "key") ?? "","state_type": orderStatus],method : .get,  success: { (response) in
            
            weakSelf?.hiddenLoadingView()
//            weakSelf?.closeRefresh()
            GYZLog(response)
            
            if response["code"].intValue == kQuestSuccessTag{//请求成功
                
                guard let data = response["datas"]["order_group_list"].array else { return }
                
                for item in data{
                    guard let dataInfo = item["order_list"].array else { return }
                    guard let itemInfo = dataInfo[0].dictionaryObject else { return }
                    let model = KZOrderModel.init(dict: itemInfo)
                    
                    weakSelf?.dataList.append(model)
                }
                if weakSelf?.dataList.count > 0{
                    weakSelf?.hiddenEmptyView()
                    weakSelf?.tableView.reloadData()
                }else{
                    ///显示空页面
                    weakSelf?.showEmptyView(content: "暂无订单信息")
                }
                
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["datas"]["error"].stringValue)
            }
            
        }, failture: { (error) in
            
            weakSelf?.hiddenLoadingView()
//            weakSelf?.closeRefresh()
            GYZLog(error)
            weakSelf?.showEmptyView(content: "加载失败，请点击重新加载", reload: {
                weakSelf?.requestOrderDatas()
                weakSelf?.hiddenEmptyView()
            })
//            if weakSelf?.currPage == 1{//第一次加载失败，显示加载错误页面
//                weakSelf?.showEmptyView(content: "加载失败，请点击重新加载", reload: {
//                    weakSelf?.refresh()
//                    weakSelf?.hiddenEmptyView()
//                })
//            }
        })
    }
    
    
    // MARK: - 上拉加载更多/下拉刷新
    /// 下拉刷新
//    func refresh(){
//        currPage = 1
//        requestOrderDatas()
//    }
//
//    /// 上拉加载更多
//    func loadMore(){
//        currPage += 1
//        requestOrderDatas()
//    }
//
//    /// 关闭上拉/下拉刷新
//    func closeRefresh(){
//        if tableView.mj_header.isRefreshing{//下拉刷新
//            dataList.removeAll()
//            GYZTool.endRefresh(scorllView: tableView)
//        }else if tableView.mj_footer.isRefreshing{//上拉加载更多
//            GYZTool.endLoadMore(scorllView: tableView)
//        }
//    }
    
}

extension KZOrderVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataList.count > 0 {
            return (dataList[section].goodList?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: orderCell) as! KZOrderCell
        cell.dataModel = dataList[indexPath.section].goodList?[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: orderHeader) as! KZOrderHeaderView
        
        headerView.dataModel = dataList[section]
        
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: orderFooter) as! KZOrderFooterView
        footerView.dataModel = dataList[section]
        
        return footerView
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kTitleHeight
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }
}
