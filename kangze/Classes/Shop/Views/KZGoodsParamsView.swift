//
//  KZGoodsParamsView.swift
//  kangze
//  商品参数
//  Created by gouyz on 2018/9/7.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

class KZGoodsParamsView: UIView {
    
    /// 数据源
    var dataSource = [String]()
    
    // MARK: 生命周期方法
    override init(frame:CGRect){
        super.init(frame:frame)
        
        addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 初始化tableViewxx
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.dataSource = self
        table.delegate = self
        table.tableFooterView = UIView()
        table.separatorStyle = .none
        
        table.register(GYZSheetCell.self, forCellReuseIdentifier: GYZSheetCellIdentifier)
        
        return table
    }()

}
extension KZGoodsParamsView : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellH
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GYZSheetCellIdentifier) as! GYZSheetCell
        
        if cellTextColor != nil {
            cell.titleLab.textColor = cellTextColor
        }
        if cellTextFont != nil {
            cell.titleLab.font = cellTextFont
        }
        
        switch cellTextStyle {
        case .Left:
            cell.titleLab.textAlignment = .left
        case .Right:
            cell.titleLab.textAlignment = .right
        default:
            cell.titleLab.textAlignment = .center
        }
        
        cell.lineView.isHidden = !showDivLine
        cell.titleLab.text = dataSource[indexPath.row]
        
        if selectedIndexs.contains(indexPath.row) {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if self.tableView.allowsMultipleSelection {
            //判断该行原先是否选中
            if let index = selectedIndexs.index(of: indexPath.row){
                selectedIndexs.remove(at: index)//原来选中的取消选中
            }else{
                selectedIndexs.append(indexPath.row) //原来没选中的就选中
            }
            
            ////刷新该行
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            
            delegate?.sheetViewDidMultSelect(indexs: selectedIndexs)
            
        }else{
            delegate?.sheetViewDidSelect(index: indexPath.row, title: dataSource[indexPath.row])
        }
        
    }
}

