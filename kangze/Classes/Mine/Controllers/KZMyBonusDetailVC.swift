//
//  KZMyBonusDetailVC.swift
//  kangze
//  一级市场
//  Created by gouyz on 2018/9/6.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

private let myBonusDetailCell = "myBonusDetailCell"

class KZMyBonusDetailVC: GYZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "一级市场"
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
        
        table.register(KZMyShouRuCell.self, forCellReuseIdentifier: myBonusDetailCell)
        
        return table
    }()
    
    
}

extension KZMyBonusDetailVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: myBonusDetailCell) as! KZMyShouRuCell
        
        if indexPath.row == 0 {
            cell.nameLab.textColor = kBlueFontColor
            cell.nameLab.text = "一级代理"
            cell.dateLab.textColor = kBlueFontColor
            cell.dateLab.text = "时间"
            cell.moneyLab.textColor = kBlueFontColor
            cell.moneyLab.text = "当月业绩"
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
        
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = KZMyVIPManagerVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kTitleHeight
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
}
