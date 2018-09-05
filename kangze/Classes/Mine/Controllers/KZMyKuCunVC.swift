//
//  KZMyKuCunVC.swift
//  kangze
//  我的库存
//  Created by gouyz on 2018/9/5.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

private let myKuCunCell = "myKuCunCell"

class KZMyKuCunVC: GYZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "我的库存"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
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
        table.separatorColor = kGrayLineColor
        
        table.register(KZMyKuCunCell.self, forCellReuseIdentifier: myKuCunCell)
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
    /// 商品详情
//    func goGoodsDetail(){
//        let vc = KZGoodsDetailVC()
//        navigationController?.pushViewController(vc, animated: true)
//    }
    /// 申请发货
    @objc func clickedSendBtn(sender: UIButton){
        
        let vc = KZApplySendVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    /// 历史发货
    @objc func clickedHistoryBtn(sender: UIButton){
//        let tag = sender.tag
        
        let vc = KZHistorySendRecordVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension KZMyKuCunVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: myKuCunCell) as! KZMyKuCunCell
        
        if indexPath.row == 2 {
            let name: String = "合伙人套餐  澳洲原装天然海藻油DHA帮助大脑发育增强记忆降低血糖全球妈妈的首选"
            let nameAttr : NSMutableAttributedString = NSMutableAttributedString(string: name)
            nameAttr.addAttribute(NSAttributedStringKey.foregroundColor, value: kRedFontColor, range: NSMakeRange(0, 5))
            cell.nameLab.attributedText = nameAttr
        }else{
            cell.nameLab.text = "澳洲原装天然海藻油DHA帮助大脑发育增强记忆降低血糖全球妈妈的首选"
        }
        
        cell.sendBtn.tag = indexPath.row
        cell.sendBtn.addTarget(self, action: #selector(clickedSendBtn(sender:)), for: .touchUpInside)
        cell.historySendBtn.tag = indexPath.row
        cell.historySendBtn.addTarget(self, action: #selector(clickedHistoryBtn(sender:)), for: .touchUpInside)
        
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
        
//        goGoodsDetail()
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
