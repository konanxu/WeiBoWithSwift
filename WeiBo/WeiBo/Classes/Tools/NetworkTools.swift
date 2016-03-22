//
//  NetworkTools.swift
//  WeiBo
//
//  Created by Konan on 16/3/15.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

import Alamofire
import AFNetworking

class NetworkTools: AFHTTPSessionManager {
    
    static let instance :NetworkTools = {
        let url = NSURL(string: "https://api.weibo.com/")
        let t = NetworkTools(baseURL: url)
        //设置afn能够接收类型
        t.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript","text/plain","text/html") as? Set<String>
        return t
        
    }()
    
    class func shareNetworkTools() -> NetworkTools{
        return instance
    }
    
    
}
