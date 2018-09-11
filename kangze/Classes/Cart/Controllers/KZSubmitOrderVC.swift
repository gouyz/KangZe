//
//  KZSubmitOrderVC.swift
//  kangze
//  提交订单
//  Created by gouyz on 2018/9/4.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit
import MBProgressHUD

private let submitOrderCell = "submitOrderCell"
private let submitOrderNoteCell = "submitOrderNoteCell"
private let submitOrderFooterView = "submitOrderFooterView"

class KZSubmitOrderVC: GYZBaseVC {
    
    var dataModel: KZSubmitOrderModel?
    /// 会员预存款余额
    var memberMoney: String = "0"
    /// 是否是购物车过来的
    var isCart: String = "0"
    /// 购物信息（商品/购物车id|购买数量）
    var cartIds: String = ""
    /// 商品总数
    var totalNum: Int = 0
    /// 备注
    var noteText: String = ""

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
        
        requestOrderInfo()
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
        payView.yuEMoneyLab.text = "可用余额：￥\(memberMoney)"
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
    /// 获取确认订单数据
    func requestOrderInfo(){
        if !GYZTool.checkNetWork() {
            return
        }
        
        weak var weakSelf = self
        createHUD(message: "加载中...")
        
        GYZNetWork.requestNetwork("member_buy&op=buy_step1", parameters: ["key": userDefaults.string(forKey: "key") ?? "","cart_id":cartIds,"ifcart":isCart],  success: { (response) in
            
            weakSelf?.hud?.hide(animated: true)
            GYZLog(response)
            if response["code"].intValue == kQuestSuccessTag{//请求成功
            
                weakSelf?.memberMoney = response["datas"]["store_cart_list"]["available_predeposit"].stringValue
                
                guard let data = response["datas"]["store_cart_list"]["1"].dictionaryObject else { return }
                weakSelf?.dataModel = KZSubmitOrderModel.init(dict: data)
                
                weakSelf?.tableView.reloadData()
            }else{
                MBProgressHUD.showAutoDismissHUD(message: response["datas"]["error"].stringValue)
            }
            
        }, failture: { (error) in
            weakSelf?.hud?.hide(animated: true)
            GYZLog(error)
        })
    }
    /// 监听UITextField输入变化
    @objc func txtFieldDidChangeValue(textField: UITextField){
        noteText = textField.text!
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
        if dataModel != nil {
            return (dataModel?.goodList?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: submitOrderCell) as! KZOrderCell
            
            cell.contentView.backgroundColor = kWhiteColor
            let model = dataModel?.goodList![indexPath.row]
            cell.dataModel = model
            
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: submitOrderNoteCell) as! GYZLabAndFieldCell
            
            cell.titleLab.text = "备注"
            cell.textFiled.addTarget(self, action: #selector(txtFieldDidChangeValue(textField:)), for: .valueChanged)
            
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
            
            if dataModel != nil{
                footerView.totalLab.text = "共\(totalNum)件商品  合计：￥" + String(format:"%.2f",Double((dataModel?.store_goods_total)!)!)
            }
            
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
