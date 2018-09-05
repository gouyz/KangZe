//
//  KZSubmitOrderVC.swift
//  kangze
//  提交订单
//  Created by gouyz on 2018/9/4.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

private let submitOrderCell = "submitOrderCell"
private let submitOrderNoteCell = "submitOrderNoteCell"
private let submitOrderFooterView = "submitOrderFooterView"

class KZSubmitOrderVC: GYZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "提交订单"
        self.view.backgroundColor = kWhiteColor
        
        view.addSubview(submitBtn)
        view.addSubview(tableView)
        
        submitBtn.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(kBottomTabbarHeight)
        }
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.bottom.equalTo(submitBtn.snp.top)
            make.top.equalTo(view)
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
        
        table.register(KZOrderCell.self, forCellReuseIdentifier: submitOrderCell)
        table.register(GYZLabAndFieldCell.self, forCellReuseIdentifier: submitOrderNoteCell)
        table.register(KZSubmitOrderFooterView.self, forHeaderFooterViewReuseIdentifier: submitOrderFooterView)
        
        return table
    }()
    
    /// 提交订单
    lazy var submitBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = kBtnClickBGColor
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kWhiteColor, for: .normal)
        btn.setTitle("提交订单", for: .normal)
        btn.addTarget(self, action: #selector(clickedSubmitBtn), for: .touchUpInside)
        
        return btn
    }()
    /// 提交订单
    @objc func clickedSubmitBtn(){
        showPayView()
    }
    
    func showPayView(){
        let payView = KZSelectPayMethodView()
        payView.selectPayTypeBlock = { [weak self](index) in
            
            payView.hide()
            self?.dealPay(index: index)
        }
        payView.show()
    }
    /// 支付
    func dealPay(index: Int){
        
        let vc = KZPosPayVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension KZSubmitOrderVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: submitOrderCell) as! KZOrderCell
            
            cell.contentView.backgroundColor = kWhiteColor
            
            
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: submitOrderNoteCell) as! GYZLabAndFieldCell
            
            cell.titleLab.text = "备注"
            
            cell.selectionStyle = .none
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 {
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: submitOrderFooterView) as! KZSubmitOrderFooterView
            
            return footerView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        goGoodsDetail()
    }
    ///MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 100
        }
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kMargin
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return kTitleHeight
        }
        return 0.00001
    }
}
