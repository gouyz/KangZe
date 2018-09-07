//
//  KZKuCunInfoVC.swift
//  kangze
//  库存明细
//  Created by gouyz on 2018/9/7.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

private let kuCunInfoCell = "kuCunInfoCell"
private let kuCunInfoHeader = "kuCunInfoHeader"

class KZKuCunInfoVC: GYZBaseVC {

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
        table.separatorColor = kGrayLineColor
        
        table.register(KZKuCunInfoCell.self, forCellReuseIdentifier: kuCunInfoCell)
        table.register(LHSGeneralHeaderView.self, forHeaderFooterViewReuseIdentifier: kuCunInfoHeader)
        
        return table
    }()
    
}

extension KZKuCunInfoVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kuCunInfoCell) as! KZKuCunInfoCell
        
        if indexPath.row == 0 {
            cell.titleLab.textColor = kBlueFontColor
            cell.titleLab.text = "产品"
            cell.numberLab.textColor = kBlueFontColor
            cell.numberLab.text = "数量"
        }else{
            cell.titleLab.textColor = kBlackFontColor
            cell.titleLab.text = "美好时光钙镁锌"
            cell.numberLab.textColor = kBlackFontColor
            cell.numberLab.text = "88"
        }
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: kuCunInfoHeader) as! LHSGeneralHeaderView
        
        headerView.lineView.isHidden = true
        headerView.nameLab.font = k12Font
        headerView.nameLab.textColor = kGaryFontColor
        let name: String = "库存明细  总库存：288"
        let nameAttr : NSMutableAttributedString = NSMutableAttributedString(string: name)
        nameAttr.addAttribute(NSAttributedStringKey.foregroundColor, value: kBlackFontColor, range: NSMakeRange(0, 4))
        nameAttr.addAttribute(NSAttributedStringKey.font, value: k15Font, range: NSMakeRange(0, 4))
        headerView.nameLab.attributedText = nameAttr
        
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
