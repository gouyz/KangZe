//
//  KZGoodsModel.swift
//  kangze
//  商品model
//  Created by gouyz on 2018/9/8.
//  Copyright © 2018年 gyz. All rights reserved.
//

import UIKit

@objcMembers
class KZGoodsModel: LHSBaseModel {
    /// id
    var goods_id : String?
    /// 商品名称
    var goods_name : String?
    /// 商品价格
    var goods_price : String? = ""
    /// 商品个数
    var goods_num : String? = ""
    /// 缩略图url
    var goods_image_url : String? = ""
    /// 商品图片的url路径
    var goods_image : String? = ""
    /// 店铺id
    var store_id : String?
    /// 商品广告词
    var goods_jingle : String?
    /// 市场价
    var goods_marketprice : String? = ""
    /// 销售数量
    var goods_salenum : String? = ""
    /// 商店名称
    var store_name : String? = ""
    /// 该商品的当前月售量
    var month_sell_count : String? = ""
    /// 该商品的付款人数
    var pay_count : String? = ""
    /// 套餐名称
    var goos_type_str : String? = ""
    /// 是否为平台自营
    var is_own_shop : String? = ""
    
    /// 是否收藏
    var is_collect : String? = ""
    /// 详情页的html
    var mobile_body : String? = ""
    /// 商品状态 0下架，1正常，10违规（禁售）
    var goods_state : String? = ""
    /// 商品审核 1通过，0未通过，10审核中
    var goods_verify : String? = ""
    /// 添加时间
    var goods_addtime : String? = ""
    /// 商品推荐 1是，0否，默认为0
    var goods_commend : String? = ""
    /// 1.普通型商品  2.合伙人套餐  3.续货型套餐
    var goods_type : String? = ""
    /// 类型名称
    var goods_type_name : String? = ""
    /// 会员类型
    var member_type_name : String? = ""
    /// 商品属性
    var attr : KZGoodsAttrModel?
    /// 会员信息
    var member : [String: String]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "attr"{
            guard let datas = value as? [String : Any] else { return }
            attr = KZGoodsAttrModel.init(dict: datas)
        }else if key == "member"{
            member = [String: String]()
            guard let datas = value as? [String : Any] else { return }
            member!["is_login"] = datas["is_login"] as? String
            member!["is_shehe"] = datas["is_shehe"] as? String
            member!["is_buydl"] = datas["is_buydl"] as? String
            member!["member_id"] = datas["member_id"] as? String
        }
        else {
            super.setValue(value, forKey: key)
        }
    }
}

/// 商品参数
@objcMembers
class KZGoodsAttrModel: LHSBaseModel{
    
    /// 生产日期   时间戳
    var goods_produce_time : String?
    /// 品牌名称
    var brand_name : String?
    /// 系类
    var gc_name : String? = ""
    /// 型号
    var goods_xinghao : String? = ""
    /// 是否是进口的
    var is_imported : String? = ""
    /// 包装种类
    var packaging_type : String? = ""
    /// 适用阶段
    var applicable_user : String?
}

