//
//  User.swift
//  WeiBo
//
//  Created by Konan on 16/3/18.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

class User: NSObject {
    //用户ID
    var id:Int = 0
    //友好显示名称
    var name:String?
    //头像地址
    var profile_image_url:String?{
        didSet{
            if let urlStr = profile_image_url{
                image_url = NSURL(string: urlStr)
            }
        }
    }
    
    var image_url:NSURL?
    
    //是否认证
    var verigied:Bool = false
    //认证类型
    var verified_type :Int = -1{
        didSet{
            switch verified_type{
            case 0:
                verigiedImage = UIImage(named: "avatar_vip")
            case 2,3,5:
                verigiedImage = UIImage(named: "avatar_enterprise_vip")
            case 220:
                verigiedImage = UIImage(named: "avatar_grassroot")
            default:
                verigiedImage = nil
            }
        }
    }
    
    
    var verigiedImage:UIImage?
    
    
    var mbrank:NSNumber?{
        didSet{
            switch mbrank as! Int{
            case 0:
                mbrankImage = UIImage(named: "common_icon_membership_expired")
            case 1,2,3,4,5,6:
                mbrankImage = UIImage(named: "common_icon_membership_level"+"\(mbrank as! Int)")
            default:
                verigiedImage = nil
            }
        }
    }
    var mbrankImage:UIImage?
    
    init(dict:[String:AnyObject]){
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    var properties = ["id","name","profile_image_url","verigied","verified_type"]
    override var description :String{
        let dict = dictionaryWithValuesForKeys(properties)
        return "\(dict)"
    }
}
