//
//  Status.swift
//  WeiBo
//
//  Created by Konan on 16/3/17.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

import SDWebImage
class Status: NSObject {
    //创建时间
    var created_at :String?{
        didSet{
            print(created_at)
            created_at = "Sat Mar 18 20:35:38 +0800 2016"
            let  createDate = NSDate.dateWithStr(created_at!)
            created_at = createDate.descDate
        }
    }
    //ID
    var id :Int = 0
    //信息内容
    var text:String?
    //来源
    var source :String?{
        didSet{
            if  let str = source{

                if  str == ""
                {
                    return
                }
                let startLocation = (str as NSString).rangeOfString(">").location + 1
                let length = (str as NSString).rangeOfString("<", options: NSStringCompareOptions.BackwardsSearch).location - startLocation
                source = "来自: " + (str as NSString).substringWithRange(NSMakeRange(startLocation, length))
            }
        }
    }
    
    //配图数组
    var pic_urls :[[String:AnyObject]]?{
        didSet{
            storedPicURLS = [NSURL]()
            for dict in pic_urls!{
                if let urlStr = dict["thumbnail_pic"]{
                    storedPicURLS?.append(NSURL(string: urlStr as! String)!)
                }
            }
        }
    }
    var bmiddle_pic:String?{
        didSet{
            guard let urlStr = bmiddle_pic else{
                return
            }
            bmiddle_picUrl = NSURL(string: bmiddle_pic!)
        }
    }
    var bmiddle_picUrl:NSURL?
    var storedPicURLS : [NSURL]?
    
    var user:User?
    
    
    var retweeted_status:Status?
    
    var pictureURLS:[NSURL]?{
        return retweeted_status != nil ? retweeted_status?.storedPicURLS : storedPicURLS
    }
    
    init(dict:[String:AnyObject]){
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {

        if "user" == key
        {
            user = User(dict: value as! [String:AnyObject])
            return
        }
        
        if  "retweeted_status" == key{
            retweeted_status = Status(dict: value as! [String:AnyObject])
            return
        }
        
            super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    class func loadStatus(since_id:Int,max_id:Int, finished:(models:[Status]?,error:NSError?) ->()){
        let path = "2/statuses/home_timeline.json"
        var paramers = ["access_token":UserAccount.loadAccount()!.access_token!]
        
        
        if  since_id > 0{
            paramers["since_id"] = "\(since_id)"
        }
        if max_id > 0{
            paramers["max_id"] = "\(max_id - 1)"
        }
        
        NetworkTools.shareNetworkTools().GET(path, parameters: paramers, success: { (_, JSON) -> Void in
//            let result = JSON["statuses"] as! [[String:AnyObject]]
//            let Status(dict: result )
            print(JSON)
            let models = Status.dictToModels(JSON!["statuses"] as! [[String:AnyObject]])
            
            
            //缓存微博配图
            cacheStatusImages(models, finished: finished)
            
            
//            finished(models: models, error: nil)
            }) { (_, error) -> Void in
                finished(models: nil, error: error)
        }
    }
    
    
    class func cacheStatusImages(list:[Status],finished:(models:[Status]?,error:NSError?) ->()){
        
        
        if list.count == 0{
           finished(models: list, error: nil) 
        }
        
        let group = dispatch_group_create()
        
        
        for status in list{
            
            //swift2.0新语法守护
//            guard let url = status.storedPicURLS else{
//                continue
//            }
            
            guard let url = status.pictureURLS else{
                continue
            }
            let middleImageurl = status.bmiddle_picUrl
            print(middleImageurl)
            dispatch_group_enter(group)
            SDWebImageManager.sharedManager().downloadImageWithURL(middleImageurl, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (_, _, _, _, _) -> Void in
                print("middle DownLoad Completed")
                dispatch_group_leave(group)
            })
            
            for url in status.pictureURLS!{
                print(url)
                
                dispatch_group_enter(group)
                
                //缓存图片
                SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (_, _, _, _, _) -> Void in
                    print("DownLoad Completed")
                    dispatch_group_leave(group)
                })
            }
            
            
        }
        
        //当所有拖欠下载完毕再通知调用者
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            print("over")
            finished(models: list, error: nil)
        }
        
    }
    
    
    class func dictToModels(dict:[[String:AnyObject]]) ->[Status]{
        var models = [Status]()
        for item in dict{
//            item as [String:AnyObject]
            models.append(Status(dict: item))
        }
        return models
    }
    
    
    //打印当前模型
    var properties = ["created_at","id","text","source","pic_urls"]
    override var description :String{
        let dict = dictionaryWithValuesForKeys(properties)
        return "\(dict)"
    }
}
