//
//  KZGoodsFavouriteVC.swift
//  kangze
//  商品收藏
//  Created by gouyz on 2018/9/4.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit
import MBProgressHUD

private let goodsFavouriteCell = "goodsFavouriteCell"

class KZGoodsFavouriteVC: GYZBaseVC {
    
    var currPage : Int = 1
    var dataList: [KZGoodsModel] = [KZGoodsModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "商品收藏"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        requestGoodsDatas()
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
        
        table.register(KZGoodsFavouriteCell.self, forCellReuseIdentifier: goodsFavouriteCell)
        weak var weakSelf = self
        ///添加下拉刷新
        GYZTool.addPullRefresh(scorllView: table, pullRefreshCallBack: {
            weakSelf?.refresh()
        })
        ///添加上拉加载更多
        GYZTool.addLoadMore(scorllView: table, loadMoreCallBack: {
            weakSelf?.loadMore()
        })
        return table
    }()
    
    ///获取数据
    func requestGoodsDatas(){
        
        weak var weakSelf = self
        showLoadingView()
        
        GYZNetWork.requestNetwork("member_favorites&op=favorites_list",parameters: ["curpage":currPage,"page":kPageSize,"key": userDefaults.string(forKey: "key") ?? ""],method : .get,  success: { (response) in
            
            weakSelf?.hiddenLoadingView()
            weakSelf?.closeRefresh()
            GYZLog(response)
            
            if response["code"].intValue == kQuestSuccessTag{//请求成功
                
                guard let data = response["datas"]["favorites_list"].array else { return }
                
                for item in data{
                    guard let itemInfo = item.dictionaryObject else { return }
                    let model = KZGoodsModel.init(dict: itemInfo)
                    
                    weakSelf?.dataList.append(model)
                }
                if weakSelf?.dataList.count > 0{
                    weakSelf?.hiddenEmptyView()
                    weakSelf?.tableView.reloadData()
                }else{
                    ///显示空页面
                    weakSelf?.showEmptyView(content: "暂无收藏商品信息")
                }
                
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["datas"]["error"].stringValue)
            }
            
        }, failture: { (error) in
            
            weakSelf?.hiddenLoadingView()
            weakSelf?.closeRefresh()
            GYZLog(error)
            
            if weakSelf?.currPage == 1{//第一次加载失败，显示加载错误页面
                weakSelf?.showEmptyView(content: "加载失败，请点击重新加载", reload: {
                    weakSelf?.refresh()
                    weakSelf?.hiddenEmptyView()
                })
            }
        })
    }
    
    
    // MARK: - 上拉加载更多/下拉刷新
    /// 下拉刷新
    func refresh(){
        currPage = 1
        requestGoodsDatas()
    }
    
    /// 上拉加载更多
    func loadMore(){
        currPage += 1
        requestGoodsDatas()
    }
    
    /// 关闭上拉/下拉刷新
    func closeRefresh(){
        if tableView.mj_header.isRefreshing{//下拉刷新
            dataList.removeAll()
            GYZTool.endRefresh(scorllView: tableView)
        }else if tableView.mj_footer.isRefreshing{//上拉加载更多
            GYZTool.endLoadMore(scorllView: tableView)
        }
    }
    /// 商品详情
    func goGoodsDetail(index: Int){
        let vc = KZGoodsDetailVC()
        vc.goodsId = dataList[index].goods_id!
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension KZGoodsFavouriteVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: goodsFavouriteCell) as! KZGoodsFavouriteCell
        
        cell.dataModel = dataList[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        goGoodsDetail(index: indexPath.row)
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
}

