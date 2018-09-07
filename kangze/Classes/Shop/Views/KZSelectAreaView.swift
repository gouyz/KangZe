//
//  KZSelectAreaView.swift
//  kangze
//  选择区域
//  Created by gouyz on 2018/9/7.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

private let selectAreaCell = "selectAreaCell"

class KZSelectAreaView: UIView {

    /// 数据源
    var dataSource = [String]()
    
    let titleArr: [String] = ["生产日期","品牌","系类","型号","所含营养","是否进口","包装种类","适用阶段"]
    
    // MARK: 生命周期方法
    override init(frame:CGRect){
        super.init(frame:frame)
    }
    convenience init(){
        let rect = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        self.init(frame: rect)
        
        self.backgroundColor = UIColor.clear
        
        backgroundView.frame = rect
        backgroundView.alpha = 0
        backgroundView.backgroundColor = kBlackColor
        addSubview(backgroundView)
        backgroundView.addOnClickListener(target: self, action: #selector(onTapCancle(sender:)))
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI(){
        
        addSubview(bgView)
        bgView.addOnClickListener(target: self, action: #selector(onBlankClicked))
        
        bgView.addSubview(tableView)
        
        bgView.frame = CGRect.init(x: 0, y: frame.size.height, width: kScreenWidth, height: kScreenHeight * 0.7)
        
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(bgView)
        }
    }
    
    ///整体背景
    var backgroundView: UIView = UIView()
    /// 透明背景
    var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = kWhiteColor
        view.cornerRadius  = kCornerRadius
        
        return view
    }()
    
    /// 初始化tableViewxx
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        
        table.register(GYZLabArrowCell.self, forCellReuseIdentifier: selectAreaCell)
        
        return table
    }()
    /// 显示
    func show(){
        UIApplication.shared.keyWindow?.addSubview(self)
        
        addAnimation()
    }
    
    ///添加显示动画
    func addAnimation(){
        
        weak var weakSelf = self
        UIView.animate(withDuration: 0.5, animations: {
            
            weakSelf?.bgView.frame = CGRect.init(x: (weakSelf?.bgView.frame.origin.x)!, y: (weakSelf?.frame.size.height)! - (weakSelf?.bgView.frame.size.height)!, width: (weakSelf?.bgView.frame.size.width)!, height: (weakSelf?.bgView.frame.size.height)!)
            
            //            weakSelf?.bgView.center = (weakSelf?.center)!
            weakSelf?.backgroundView.alpha = 0.2
            
        }) { (finished) in
            
        }
    }
    
    ///移除动画
    func removeAnimation(){
        weak var weakSelf = self
        UIView.animate(withDuration: 0.5, animations: {
            
            weakSelf?.bgView.frame = CGRect.init(x: (weakSelf?.bgView.frame.origin.x)!, y: (weakSelf?.frame.size.height)!, width: (weakSelf?.bgView.frame.size.width)!, height: (weakSelf?.bgView.frame.size.height)!)
            weakSelf?.backgroundView.alpha = 0
            
        }) { (finished) in
            weakSelf?.removeFromSuperview()
        }
    }
    /// 隐藏
    func hide(){
        removeAnimation()
    }
    
    /// 点击bgView不消失
    @objc func onBlankClicked(){
        
    }
    
    /// 点击空白取消
    @objc func onTapCancle(sender:UITapGestureRecognizer){
        
        hide()
    }
    
}
extension KZSelectAreaView : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: selectAreaCell) as! GYZLabArrowCell
        
        cell.rightIconView.isHidden = true
        cell.nameLab.text = titleArr[indexPath.row]
        
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
        return kTitleHeight
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
}
