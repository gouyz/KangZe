//
//  KZHomeVC.swift
//  kangze
//  首页
//  Created by gouyz on 2018/8/28.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit
import MBProgressHUD

private let homeCell = "homeCell"

class KZHomeVC: KZCommonNavBarVC {
    
    var dataModel: KZHomeModel?
    let titleArr: [String] = ["本周热销","合伙人套餐","续货套餐"]
    let iconArr: [String] = ["icon_home_hot_sale","icon_home_hehuo","icon_home_xuhuo"]

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
        navBarView.searchBtn.addTarget(self, action: #selector(clickedSearchBtn), for: .touchUpInside)
        
        requestHomeDatas()
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
    
    ///获取首页数据
    func requestHomeDatas(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("goods&op=shop_index",parameters: nil,method : .get,  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            
            if response["code"].intValue == kQuestSuccessTag{//请求成功
                
                guard let data = response["datas"].dictionaryObject else { return }
                weakSelf?.dataModel = KZHomeModel.init(dict: data)
                weakSelf?.setData()
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["datas"]["error"].stringValue)
            }
            
        }, failture: { (error) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    
    func setData(){
        headerView.adsImgView.setUrlsGroup([(dataModel?.header_pic)!])
        tableView.reloadData()
    }
    
    /// 公司动态、订单、朋友圈素材、消息
    func dealOperator(index : Int){
        switch index {
        case 1://公司动态
            goDynamic()
        case 2://订单
            goOrder()
        case 3://朋友圈素材
            goFriendCircle()
        case 4://消息
            goMsg()
        default:
            break
        }
    }
    ///公司动态
    func goDynamic(){
        let vc = KZCompanyDynamicManagerVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    ///订单
    func goOrder(){
        let vc = KZOrderManagerVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    ///朋友圈
    func goFriendCircle(){
        let vc = KZFriendCircleVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    ///消息
    func goMsg(){
        let vc = KZMessageVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 商品详情
    func goGoodsDetail(index: Int){
        let vc = KZGoodsDetailVC()
        vc.goodsId = (dataModel?.goodList![index].goods_id)!
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension KZHomeVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataModel != nil {
            return (dataModel?.goodList!.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCell) as! KZHomeCell
        
        let model = dataModel?.goodList![indexPath.row]
        
        cell.iconView.image = UIImage.init(named: iconArr[indexPath.row])
        cell.nameLab.text = titleArr[indexPath.row]
        cell.adsImgView.kf.setImage(with: URL.init(string: (model?.goods_image)!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        
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
        return (kScreenWidth - kMargin * 2) * 0.5 + 70
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
}
