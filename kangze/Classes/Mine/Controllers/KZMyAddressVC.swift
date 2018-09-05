//
//  KZMyAddressVC.swift
//  kangze
//  我的地址
//  Created by gouyz on 2018/9/5.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

private let myAddressCell = "myAddressCell"

class KZMyAddressVC: GYZBaseVC {
    
    /// 选择结果回调
//    var resultBlock:((_ model: LHSReceiveAddressModel) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "我的地址"
        view.addSubview(submitBtn)
        view.addSubview(tableView)
        
        submitBtn.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(kBottomTabbarHeight)
        }
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.bottom.equalTo(submitBtn.snp.top)
            if #available(iOS 11.0, *) {
                make.top.equalTo(view)
            }else{
                make.top.equalTo(kTitleAndStateHeight)
            }
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
        
        // 设置大概高度
        table.estimatedRowHeight = 100
        // 设置行高为自动适配
        table.rowHeight = UITableViewAutomaticDimension
        
        table.register(KZMyAddressCell.self, forCellReuseIdentifier: myAddressCell)
        
        return table
    }()
    
    /// 添加新地址
    lazy var submitBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = kBtnClickBGColor
        btn.titleLabel?.font = k15Font
        btn.setTitleColor(kWhiteColor, for: .normal)
        btn.setTitle("添加新地址", for: .normal)
        btn.addTarget(self, action: #selector(clickedSubmitBtn), for: .touchUpInside)
        
        return btn
    }()
    /// 添加新地址
    @objc func clickedSubmitBtn(){
        goEditVC(isEdit: true)
    }
    
    /// 删除地址
    @objc func onClickedDelBtn(sender: UIButton){
    }
    /// 编辑地址
    @objc func onClickedEditBtn(sender: UIButton){
        
        goEditVC(isEdit: false)
    }
    
    /// 编辑/新增地址
    ///
    /// - Parameter isEdit: 是增加还是编辑
    func goEditVC(isEdit: Bool){
        let editVC = KZEditAddressVC()
        editVC.isAdd = isEdit
//        editVC.addressInfo = addressInfo
        navigationController?.pushViewController(editVC, animated: true)
    }
}
extension KZMyAddressVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: myAddressCell) as! KZMyAddressCell
        
        cell.delBtn.tag = indexPath.row
        cell.delBtn.addTarget(self, action: #selector(onClickedDelBtn(sender:)), for: .touchUpInside)
        cell.editBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(onClickedEditBtn(sender:)), for: .touchUpInside)
        
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
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.00001
    }
}
