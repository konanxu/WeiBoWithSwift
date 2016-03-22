//
//  UserAccount.swift
//  WeiBo
//
//  Created by Konan on 16/3/15.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

class UserAccount: NSObject,NSCoding{

//    "access_token" = "2.00RpFWPD0ihXS6bc0ac2535fgqnTOD";
//    "expires_in" = 157679999;
//    "remind_in" = 157679999;
//    uid = 2977692431;
    
    var access_token:String?
    var expires_in:NSNumber?
    var uid:String?
    
    override init(){
        
    }
    init(dict: [String:AnyObject]) {
        access_token = dict["access_token"] as? String
        expires_in = dict["expires_in"] as? NSNumber
        uid = dict["uid"] as? String
    }
    
    override var description :String{
        let properties = ["access_token","expires_in","uid"]
        let dict = self.dictionaryWithValuesForKeys(properties)
        return "\(dict)"
    }
    
    
    
    func saveAccount(){
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        let filePath = (path as NSString).stringByAppendingPathComponent("account.plist")
        print("filepath\(filePath)")
        NSKeyedArchiver.archiveRootObject(self, toFile: filePath)
    }
    class func loadAccount() -> UserAccount? {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        let filePath = (path as NSString).stringByAppendingPathComponent("account.plist")
        let account = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? UserAccount
        return account
    }

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
    }
     required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        uid = aDecoder.decodeObjectForKey("uid") as? String
    }
}