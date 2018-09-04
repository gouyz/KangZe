//
//  KZFriendCircleVC.swift
//  kangze
//  朋友圈
//  Created by gouyz on 2018/9/3.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

private let friendCircleCell = "friendCircleCell"

class KZFriendCircleVC: GYZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "朋友圈"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"icon_add_black")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(onClickedAdd))
        
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
        
        // 设置大概高度
        table.estimatedRowHeight = 100
        // 设置行高为自动适配
        table.rowHeight = UITableViewAutomaticDimension
        
        table.register(KZFriendCircleCell.self, forCellReuseIdentifier: friendCircleCell)
        
        return table
    }()
    /// add
    @objc func onClickedAdd(){
        let vc = KZPublicFriendCircleVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension KZFriendCircleVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: friendCircleCell) as! KZFriendCircleCell
        
        cell.imgViews.selectImgUrls = ["icon_goods_default","icon_goods_default","icon_goods_default"]
        let rowIndex = ceil(CGFloat.init((cell.imgViews.selectImgUrls?.count)!) / CGFloat.init(cell.imgViews.perRowItemCount))//向上取整
        
        //        cell.imgViews.isHidden = false
        cell.imgViews.snp.updateConstraints({ (make) in
            
            make.height.equalTo(cell.imgViews.imgHight * rowIndex + kMargin * (rowIndex - 1))
        })
        
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
        return 0.000001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
}
