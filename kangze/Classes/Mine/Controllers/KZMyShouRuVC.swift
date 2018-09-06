//
//  KZMyShouRuVC.swift
//  kangze
//  零售收入
//  Created by gouyz on 2018/9/6.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

private let myShouRuCell = "myShouRuCell"
private let myShouRuHeader = "myShouRuHeader"

class KZMyShouRuVC: GYZBaseVC {
    
    let timeArr: [String] = ["当月","上个月","本季度","半年"]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            
            make.edges.equalTo(0)
        }
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
        
        table.register(KZMyShouRuCell.self, forCellReuseIdentifier: myShouRuCell)
        table.register(KZMyShouRuHeaderView.self, forHeaderFooterViewReuseIdentifier: myShouRuHeader)
        
        return table
    }()
    /// 选择时间
    @objc func onClickedSelectTime(){
        
        showSelectTime()
    }
    func showSelectTime(){
        GYZAlertViewTools.alertViewTools.showSheet(title: "选择时间", message: nil, cancleTitle: "取消", titleArray: timeArr, viewController: self) { [weak self](index) in
            
            if index == 0{//拍照
//                self?.openCamera()
            }else if index == 1 {//从相册选取
//                self?.openPhotos()
            }
        }
    }
    
}

extension KZMyShouRuVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: myShouRuCell) as! KZMyShouRuCell
        
        if indexPath.row == 0 {
            cell.nameLab.textColor = kBlueFontColor
            cell.nameLab.text = "姓名"
            cell.dateLab.textColor = kBlueFontColor
            cell.dateLab.text = "时间"
            cell.moneyLab.textColor = kBlueFontColor
            cell.moneyLab.text = "零售金额"
            cell.productLab.textColor = kBlueFontColor
            cell.productLab.text = "产品"
        }else{
            cell.nameLab.textColor = kBlackFontColor
            cell.nameLab.text = "张三"
            cell.dateLab.textColor = kBlackFontColor
            cell.dateLab.text = "2018-08-31"
            cell.moneyLab.textColor = kBlackFontColor
            cell.moneyLab.text = "￥20008"
            cell.productLab.textColor = kBlackFontColor
            cell.productLab.text = "合伙人套餐"
        }
        
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = kBackgroundColor
        }else{
            cell.contentView.backgroundColor = kWhiteColor
        }
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: myShouRuHeader) as! KZMyShouRuHeaderView
        
        headerView.timeLab.addOnClickListener(target: self, action: #selector(onClickedSelectTime))
        
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kTitleHeight
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kTitleHeight
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
}
