//
//  KZShouRuModel.swift
//  kangze
//  零售收入 model
//  Created by gouyz on 2018/9/11.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

@objcMembers
class KZShouRuModel: LHSBaseModel {

    /// 是否有记录
    var is_have : String?
    /// 总金额
    var total : String? = "0"
    ///
    var msg : String? = ""
    
    /// 详情列表
    var detailList: [KZShouRuChildModel]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "list"{
            detailList = [KZShouRuChildModel]()
            guard let datas = value as? [[String : Any]] else { return }
            for dict in datas {
                let model = KZShouRuChildModel(dict: dict)
                detailList?.append(model)
            }
        }else {
            super.setValue(value, forKey: key)
        }
    }
}

/// 零售收入cell model
@objcMembers
class KZShouRuChildModel: LHSBaseModel {
    
    /// 姓名
    var buyer_name : String?
    /// 时间戳
    var payment_time : String?
    /// 零售金额
    var goods_pay_price : String? = "0"
    /// 商品名称
    var goods_name : String?
    /// 会员id
    var member_id : String?
    
}
